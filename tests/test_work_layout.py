import importlib.machinery
import importlib.util
import os
from pathlib import Path
import re
import subprocess
import sys
from tempfile import TemporaryDirectory
import unittest
from unittest.mock import Mock, patch


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "dot_local/bin/executable_work_layout"
LOADER = importlib.machinery.SourceFileLoader("work_layout", str(SCRIPT))
LAYOUT = importlib.util.module_from_spec(
    importlib.util.spec_from_loader(LOADER.name, LOADER)
)
sys.modules[LOADER.name] = LAYOUT
LOADER.exec_module(LAYOUT)


def window(address, window_class, workspace):
    return {"address": address, "class": window_class,
            "workspace": {"name": workspace}}


class WorkLayoutTests(unittest.TestCase):
    def setUp(self):
        self.notes = LAYOUT.App(
            "Notes", ["notes"], re.compile("notes"), re.compile("notes"),
            None, None, "scratchpad2", False
        )
        self.terminal = LAYOUT.App(
            "Terminal", ["terminal"], re.compile("foot|work-terminal"),
            re.compile("work-terminal"), None, None, "scratchpad5", True
        )

    def test_reuses_correct_window_even_when_other_matches_exist(self):
        target = LAYOUT.Target("special:scratchpad2")
        correct = window("0x1", "notes", target.workspace)
        elsewhere = window("0x2", "notes", "1")
        self.assertEqual(LAYOUT.decide(self.notes, target, [elsewhere, correct]),
                         ("keep", None))
        self.assertEqual(LAYOUT.decide(self.notes, target, [elsewhere]),
                         ("move", "0x2"))
        second = window("0x3", "notes", "1")
        self.assertEqual(LAYOUT.decide(self.notes, target, [elsewhere, second]),
                         ("ambiguous", None))

    def test_missing_terminal_only_moves_new_window_and_repeat_keeps_it(self):
        windows = [window("0x1", "foot", "1")]
        new = window("0x2", "work-terminal", "1")

        def place(address, target):
            self.assertEqual(address, "0x2")
            new["workspace"]["name"] = target.workspace
            windows.append(new)

        with (patch.object(LAYOUT, "query", side_effect=[[], windows, [], windows]),
              patch.object(LAYOUT, "launch", return_value=new) as launch,
              patch.object(LAYOUT, "move", side_effect=place) as move,
              patch("builtins.print")):
            self.assertEqual(LAYOUT.restore({}, [self.terminal], False), [])
            self.assertEqual(LAYOUT.restore({}, [self.terminal], False), [])
        launch.assert_called_once()
        move.assert_called_once_with("0x2", LAYOUT.Target("special:scratchpad5"))
        self.assertEqual(windows[0]["workspace"]["name"], "1")

    def test_existing_ordinary_terminal_in_scratchpad_counts(self):
        target = LAYOUT.Target("special:scratchpad5")
        existing = window("0x1", "foot", target.workspace)
        self.assertEqual(LAYOUT.decide(self.terminal, target, [existing]),
                         ("keep", None))

    def test_launch_ignores_unrelated_new_terminal(self):
        original = window("0x1", "foot", "1")
        unrelated = window("0x2", "foot", "1")
        expected = window("0x3", "work-terminal", "1")
        with (patch.object(LAYOUT, "query", side_effect=[
                  [original, unrelated], [original, unrelated, expected]]),
              patch.object(LAYOUT.subprocess, "Popen", return_value=Mock(poll=lambda: 0)),
              patch.object(LAYOUT.time, "sleep")):
            self.assertIs(LAYOUT.launch(self.terminal, [original]), expected)

    def test_disconnected_monitor_skips_only_its_app(self):
        video = LAYOUT.App(
            "Video", ["video"], re.compile("video"), re.compile("video"),
            "portrait", 1, None, False
        )
        with (TemporaryDirectory() as directory,
              patch.dict(os.environ, {"XDG_STATE_HOME": directory}),
              patch.object(LAYOUT, "query", side_effect=[[], []]),
              patch.object(LAYOUT, "launch") as launch,
              patch.object(LAYOUT, "move") as move,
              patch("builtins.print") as output):
            self.assertEqual(LAYOUT.restore({"portrait": "G3"}, [video, self.notes],
                                            True), [])
        output.assert_any_call("Video: skip (portrait monitor is disconnected)")
        output.assert_any_call("Notes: would launch → special:scratchpad2")
        launch.assert_not_called()
        move.assert_not_called()

    def test_workspace_slot_uses_live_connector_and_omarchy_block(self):
        chat = LAYOUT.App(
            "Chat", ["chat"], re.compile("chat"), re.compile("chat"),
            "main", 10, None, False
        )
        monitor = {"name": "DP-9", "model": "G7", "description": "Samsung G7"}
        self.assertEqual(
            LAYOUT.target_for(chat, {"main": "G7"}, [monitor],
                              {("DP-9", "Samsung G7"): 2}),
            LAYOUT.Target("30", "DP-9"),
        )

    def test_new_workspace_is_relocated_without_unrelated_windows(self):
        target = LAYOUT.Target("30", "DP-9")
        workspace = {"name": "30", "monitor": "DP-1"}
        moved_workspace = {**workspace, "monitor": "DP-9"}
        new = window("0x2", "chat", "30")
        other = window("0x3", "browser", "1")
        with (patch.object(LAYOUT, "workspace_for",
                           side_effect=[workspace, moved_workspace]),
              patch.object(LAYOUT, "query", return_value=[new, other]),
              patch.object(LAYOUT, "dispatch") as dispatch):
            LAYOUT.move("0x2", target)
        self.assertEqual(dispatch.call_count, 2)
        self.assertIn('window = "address:0x2"', dispatch.call_args_list[0].args[0])
        self.assertIn('monitor = "DP-9"', dispatch.call_args_list[1].args[0])

    def test_concurrent_invocation_exits_before_querying_hyprland(self):
        with TemporaryDirectory() as directory:
            profile = Path(directory) / "profile.toml"
            profile.write_text('[[apps]]\nname = "Notes"\ncommand = ["notes"]\n'
                               'window_class = "notes"\nscratchpad = "notes"\n')
            with (Path(directory) / "work_layout.lock").open("a") as lock:
                LAYOUT.fcntl.flock(lock, LAYOUT.fcntl.LOCK_EX)
                result = subprocess.run(
                    [sys.executable, str(SCRIPT), "--profile", str(profile)],
                    env={**os.environ, "XDG_RUNTIME_DIR": directory},
                    text=True, capture_output=True, check=True, timeout=5,
                )
            self.assertEqual(result.stdout.strip(), "work_layout: already running")


if __name__ == "__main__":
    unittest.main()
