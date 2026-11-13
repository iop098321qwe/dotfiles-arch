"""Test the Notion modifier without opening or changing a live profile."""

import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


MODIFIER = (
    Path(__file__).resolve().parents[1]
    / "dot_config/Notion/modify_private_state.json"
)


class NotionSettingsTests(unittest.TestCase):
    @unittest.skipUnless(shutil.which("chezmoi"), "chezmoi not installed")
    def test_isolated_chezmoi_apply(self):
        temp_root = "/tmp/opencode" if Path("/tmp/opencode").is_dir() else None
        with tempfile.TemporaryDirectory(dir=temp_root) as directory:
            root = Path(directory)
            source = root / "source"
            destination = root / "home"
            modifier = source / "dot_config/Notion" / MODIFIER.name
            modifier.parent.mkdir(parents=True)
            shutil.copyfile(MODIFIER, modifier)
            target = destination / ".config/Notion/state.json"
            target.parent.mkdir(parents=True)
            config = root / "chezmoi.toml"
            config.write_text("")
            command = [
                "chezmoi", "--config", str(config), "--source", str(source),
                "--destination", str(destination), "--persistent-state",
                str(root / "state.boltdb"), "apply", str(target),
            ]
            for existing in (None, {"history": {"tab": "synthetic-page"}}):
                if existing is not None:
                    target.write_text(json.dumps(existing))
                result = subprocess.run(command, text=True, capture_output=True)
                self.assertEqual(result.returncode, 0, result.stderr)
                state = json.loads(target.read_text())
                self.assertEqual(state["appState"]["zoomFactor"], 1)
                self.assertEqual(target.stat().st_mode & 0o777, 0o600)
                if existing is not None:
                    self.assertEqual(state["history"], existing["history"])

    def run_modifier(self, text):
        return subprocess.run(
            [sys.executable, str(MODIFIER)], input=text,
            text=True, capture_output=True, check=False,
        )

    def test_first_run_contains_only_portable_settings(self):
        result = self.run_modifier("")
        self.assertEqual(result.returncode, 0, result.stderr)
        state = json.loads(result.stdout)
        self.assertEqual(set(state), {"appState"})
        self.assertEqual(set(state["appState"]), {
            "zoomFactor", "theme", "contrastMode", "locale", "preferences",
        })
        self.assertEqual(state["appState"]["theme"], {
            "mode": "dark", "usingSystemTheme": True,
        })
        self.assertEqual(set(state["appState"]["preferences"]), {
            "isHideLastWindowOnCloseEnabled", "isMenuBarIconEnabled",
            "isNavigationHistoryEnabled", "isNewTabSearchEnabled",
            "isPinnedTabNewTabEnabled", "isTabSpacesEnabled",
            "isQuickSearchEnabled", "isTabPreviewEnabled",
            "isUniversalLinksEnabled", "notionAiShortcut", "onStartup",
            "quickSearchShortcut", "isAlwaysOnTabBarEnabled", "isZenModeEnabled",
        })

    def test_merge_preserves_private_and_machine_state(self):
        state = {
            "history": {"windows": ["private-page"], "bounds": [123, 456]},
            "unknown": {"token": "synthetic-test-token"},
            "coreAudioTapGateEnabled": False,
            "appState": {
                "zoomFactor": 2,
                "theme": {"mode": "light", "colors": {"white": "#fff"}},
                "preferences": {
                    "isOpenAtLoginEnabled": False,
                    "isHardwareAccelerationDisabled": True,
                    "isDesktopBetaEnrolled": False,
                    "isAutoUpdaterDisabled": True,
                },
                "appLaunchTimestamp": 123,
            },
        }
        result = self.run_modifier(json.dumps(state))
        self.assertEqual(result.returncode, 0, result.stderr)
        merged = json.loads(result.stdout)
        for key in ("history", "unknown", "coreAudioTapGateEnabled"):
            self.assertEqual(merged[key], state[key])
        app = merged["appState"]
        self.assertEqual(app["zoomFactor"], 1)
        self.assertEqual(app["theme"]["colors"], {"white": "#fff"})
        self.assertEqual(app["appLaunchTimestamp"], 123)
        for key, value in state["appState"]["preferences"].items():
            self.assertEqual(app["preferences"][key], value)

    def test_idempotent_preserves_original_formatting(self):
        first = self.run_modifier("")
        compact = json.dumps(json.loads(first.stdout), separators=(",", ":"))
        second = self.run_modifier(compact)
        self.assertEqual(second.returncode, 0, second.stderr)
        self.assertEqual(second.stdout, compact)

    def test_invalid_state_fails_without_output_or_sensitive_error(self):
        for text in (
            "synthetic-secret", "[]", "null", '{"appState": null}',
            '{"appState": {"preferences": []}}',
            '{"appState": {"theme": "synthetic-secret"}}',
        ):
            with self.subTest(text=text):
                result = self.run_modifier(text)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(result.stdout, "")
                self.assertNotIn("synthetic-secret", result.stderr)


if __name__ == "__main__":
    unittest.main()
