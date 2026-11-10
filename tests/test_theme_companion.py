"""Isolated tests for Brave Origin extension registration; no browser is run."""

import importlib.machinery
import importlib.util
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[1] / (
    "dot_local/bin/executable_grymm-theme-companion-browser-setup"
)
LOADER = importlib.machinery.SourceFileLoader("browser_setup", str(SCRIPT))
SPEC = importlib.util.spec_from_loader(LOADER.name, LOADER)
SETUP = importlib.util.module_from_spec(SPEC)
LOADER.exec_module(SETUP)


class MergeTests(unittest.TestCase):
    def test_preserves_existing_extensions_and_flags(self):
        original = (
            "# Omarchy defaults\n"
            "--load-extension=/stock/copy-url,/stock/yt-dlp\n"
            "--enable-features=OverlayScrollbar\n"
        )
        actual = SETUP.merge_extension_flags(original, "/home/new/extension")
        self.assertEqual(actual, original.replace(
            "/stock/yt-dlp\n", "/stock/yt-dlp,/home/new/extension\n",
        ))
        self.assertEqual(SETUP.merge_extension_flags(actual, "/home/new/extension"),
                         actual)

    def test_merges_multiple_load_flags_and_deduplicates(self):
        actual = SETUP.merge_extension_flags(
            "--load-extension=/one,/two\n--other\n"
            " --load-extension=/two,/three\n", "/companion",
        )
        self.assertEqual(actual,
                         "--load-extension=/one,/two,/three,/companion\n--other\n")

    def test_creates_or_appends_flag_with_newline(self):
        self.assertEqual(SETUP.merge_extension_flags("", "/extension"),
                         "--load-extension=/extension\n")
        self.assertEqual(SETUP.merge_extension_flags("--other", "/with spaces/ext"),
                         "--other\n--load-extension=/with spaces/ext\n")

    def test_rejects_unrepresentable_extension_paths(self):
        for extension in ["/with,comma", "/with\nnewline", "/with\rreturn"]:
            with self.assertRaises(ValueError):
                SETUP.merge_extension_flags("", extension)


class ConfigureTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="theme-companion-")
        self.addCleanup(self.temporary.cleanup)
        self.home = Path(self.temporary.name)
        self.config = self.home / "custom config"
        self.data = self.home / "custom data"
        self.extension = self.data / "grymm-theme-companion/extension"
        self.extension.mkdir(parents=True)
        (self.extension / "manifest.json").write_text('{}\n')
        self.flags = self.config / "brave-origin-flags.conf"

    def test_creates_flags_in_xdg_directory_via_cli(self):
        env = {**os.environ, "HOME": str(self.home),
               "XDG_CONFIG_HOME": str(self.config), "XDG_DATA_HOME": str(self.data)}
        subprocess.run(["python3", str(SCRIPT)], env=env, check=True,
                       capture_output=True, text=True)
        self.assertEqual(self.flags.read_text(),
                         f"--load-extension={self.extension}\n")
        self.assertFalse((self.home / ".config").exists())

    def test_backs_up_preserves_permissions_and_avoids_unchanged_writes(self):
        self.config.mkdir()
        original = "--load-extension=/stock/one\n--other\n"
        self.flags.write_text(original)
        self.flags.chmod(0o600)
        self.assertTrue(SETUP.configure(self.config, self.data))
        backup = self.flags.with_name(self.flags.name + ".before-grymm-theme-companion")
        self.assertEqual(backup.read_text(), original)
        self.assertEqual(self.flags.stat().st_mode & 0o777, 0o600)
        before = self.flags.stat()
        self.assertFalse(SETUP.configure(self.config, self.data))
        self.assertEqual(self.flags.stat().st_mtime_ns, before.st_mtime_ns)
        self.assertEqual(backup.read_text(), original)
        self.assertEqual(list(self.config.glob(".brave-origin-flags.conf.*")), [])

    def test_preserves_symlink(self):
        self.config.mkdir()
        target = self.home / "linked-flags"
        target.write_text("--other\n")
        self.flags.symlink_to(target)
        SETUP.configure(self.config, self.data)
        self.assertTrue(self.flags.is_symlink())
        self.assertIn(str(self.extension), target.read_text())

    def test_missing_extension_does_not_modify_flags(self):
        (self.extension / "manifest.json").unlink()
        with self.assertRaises(FileNotFoundError):
            SETUP.configure(self.config, self.data)
        self.assertFalse(self.flags.exists())


if __name__ == "__main__":
    unittest.main()
