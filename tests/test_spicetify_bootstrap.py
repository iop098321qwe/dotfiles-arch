"""Test privileged Spicetify commands without touching Spotify or packages."""

import errno
import os
from pathlib import Path
import pty
import re
import subprocess
import tempfile
import unittest


HOOK = (
    Path(__file__).resolve().parents[1]
    / ".chezmoiscripts/run_after_001_spicetify_bootstrap.sh.tmpl"
)


class SpicetifyBootstrapTests(unittest.TestCase):
    def run_command(self, mode, *, terminal=True, gum=True, status=0,
                    restore=False):
        source = HOOK.read_text()
        # Load only function definitions, never the live bootstrap body or
        # private configuration template. Missing functions fail the test.
        names = ["run_as_root", "spin", "spin_as_root"]
        if restore:
            names.append("restore_stock_spotify_apps")
        definitions = []
        for name in names:
            match = re.search(
                rf"^{name}\(\) \{{\n.*?^\}}$", source, re.M | re.S,
            )
            self.assertIsNotNone(match, f"Missing function: {name}")
            definitions.append(match.group())

        with tempfile.TemporaryDirectory(dir="/tmp/opencode") as directory:
            root = Path(directory)
            log = root / "commands"
            mocks = {
                "pacman": (
                    'printf "pacman" >> "$COMMAND_LOG"\n'
                    'printf " <%s>" "$@" >> "$COMMAND_LOG"\n'
                    'printf "\\n" >> "$COMMAND_LOG"\n'
                    'exit "$COMMAND_STATUS"\n'
                ),
                "sudo": (
                    'printf "sudo" >> "$COMMAND_LOG"\n'
                    'printf " <%s>" "$@" >> "$COMMAND_LOG"\n'
                    'printf "\\n" >> "$COMMAND_LOG"\n'
                    'if [[ ${1:-} == -n ]]; then shift; fi\n'
                    'exec "$@"\n'
                ),
            }
            if gum:
                mocks["gum"] = (
                    'printf "gum\\n" >> "$COMMAND_LOG"\n'
                    'while [[ $# -gt 0 && $1 != -- ]]; do shift; done\n'
                    'shift\n'
                    # exec deliberately cannot resolve parent-shell functions.
                    'exec "$@"\n'
                )
            for name, body in mocks.items():
                executable = root / name
                executable.write_text("#!/bin/bash\n" + body)
                executable.chmod(0o700)

            script = "set -euo pipefail\n" + "\n".join(definitions)
            script += '\nsudo_mode="$TEST_SUDO_MODE"\n'
            if restore:
                script += """
checks=0
spotify_package_apps_are_pristine() {
  checks=$((checks + 1))
  (( checks > 2 ))
}
spotify_apps_have_directories() { return 1; }
stop_spotify() { :; }
ensure_write_access() { :; }
SPOTIFY_PATH=/unused/spotify
SPOTIFY_APPS_PATH=/unused/spotify/Apps
restore_stock_spotify_apps
"""
            else:
                script += (
                    '\nspin_as_root "Reinstalling Spotify package..." '
                    'pacman -S --noconfirm spotify\n'
                )
            env = {
                "PATH": str(root),
                "COMMAND_LOG": str(log),
                "COMMAND_STATUS": str(status),
                "TEST_SUDO_MODE": mode,
            }
            master = slave = None
            try:
                if terminal:
                    master, slave = pty.openpty()
                result = subprocess.run(
                    ["/bin/bash", "--noprofile", "--norc", "-c", script],
                    env=env, stdout=subprocess.PIPE,
                    stderr=slave if terminal else subprocess.PIPE,
                    text=True, timeout=10,
                )
                if terminal:
                    os.close(slave)
                    slave = None
                    chunks = []
                    while True:
                        try:
                            chunk = os.read(master, 4096)
                        except OSError as error:
                            if error.errno != errno.EIO:
                                raise
                            break
                        if not chunk:
                            break
                        chunks.append(chunk)
                    errors = b"".join(chunks).decode()
                else:
                    errors = result.stderr
            finally:
                if slave is not None:
                    os.close(slave)
                if master is not None:
                    os.close(master)
            commands = log.read_text().splitlines() if log.exists() else []
            return result.returncode, commands, errors

    def test_root_and_passwordless_sudo_with_spinner(self):
        for mode in ("root", "noninteractive"):
            with self.subTest(mode=mode):
                code, commands, errors = self.run_command(mode)
                self.assertEqual(code, 0, errors)
                self.assertEqual(commands[0], "gum")
                self.assertEqual(
                    commands[-1], "pacman <-S> <--noconfirm> <spotify>",
                )
                if mode == "noninteractive":
                    self.assertEqual(
                        commands[1],
                        "sudo <-n> <pacman> <-S> <--noconfirm> <spotify>",
                    )
                else:
                    self.assertEqual(len(commands), 2)
                self.assertNotIn("run_as_root", "\n".join(commands) + errors)

    def test_interactive_sudo_bypasses_spinner(self):
        code, commands, errors = self.run_command("interactive")
        self.assertEqual(code, 0, errors)
        self.assertEqual(commands, [
            "sudo <pacman> <-S> <--noconfirm> <spotify>",
            "pacman <-S> <--noconfirm> <spotify>",
        ])
        self.assertIn("Reinstalling Spotify", errors)

    def test_unavailable_privileges_do_not_run_commands(self):
        code, commands, errors = self.run_command("unavailable")
        self.assertEqual(code, 1)
        self.assertEqual(commands, [])
        self.assertIn("Root privileges are unavailable", errors)

    def test_fallback_without_terminal_or_gum(self):
        for mode in ("root", "noninteractive"):
            for terminal, gum in ((False, True), (True, False), (False, False)):
                with self.subTest(mode=mode, terminal=terminal, gum=gum):
                    code, commands, errors = self.run_command(
                        mode, terminal=terminal, gum=gum,
                    )
                    self.assertEqual(code, 0, errors)
                    self.assertNotIn("gum", commands)
                    self.assertTrue(commands[-1].startswith("pacman "))

    def test_command_failure_propagates(self):
        for mode in ("root", "noninteractive", "interactive"):
            for terminal in (False, True):
                with self.subTest(mode=mode, terminal=terminal):
                    code, _, _ = self.run_command(
                        mode, terminal=terminal, status=42,
                    )
                    self.assertEqual(code, 42)

    def test_restore_calls_privileged_spinner(self):
        code, commands, errors = self.run_command(
            "noninteractive", restore=True,
        )
        self.assertEqual(code, 0, errors)
        self.assertEqual(commands, [
            "gum",
            "sudo <-n> <pacman> <-S> <--noconfirm> <spotify>",
            "pacman <-S> <--noconfirm> <spotify>",
        ])

    def test_restore_failure_has_actionable_error(self):
        code, _, errors = self.run_command(
            "noninteractive", restore=True, status=42,
        )
        self.assertEqual(code, 1)
        self.assertIn("Resolve the error above", errors)
        self.assertNotIn("Rerun chezmoi apply in an interactive terminal", errors)


if __name__ == "__main__":
    unittest.main()
