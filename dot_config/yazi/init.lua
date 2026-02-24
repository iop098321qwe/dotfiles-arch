-- ~/.config/yazi/init.lua

-- Relative Motions
require("relative-motions"):setup({ show_numbers = "relative" })

-- Smart Enter
require("smart-enter"):setup({
  open_multi = true,
})

-- starship prompt
require("starship"):setup({
  -- Hide flags (such as filter, find and search). This is recommended for starship themes which
  -- are intended to go across the entire width of the terminal.
  hide_flags = false,                           -- Default: false
  -- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
  flags_after_prompt = true,                    -- Default: true
  -- Custom starship configuration file to use
  config_file = "~/.config/yazi_starship.toml", -- Default: nil
})

-- -- Autosession
-- require("autosession"):setup()

-- Recycle Bin
require("recycle-bin"):setup()

-- Full Border
require("full-border"):setup {
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = ui.Border.ROUNDED,
}

-- Projects
require("projects"):setup({
  event = {
    save = {
      enable = true,
      name = "project-saved",
    },
    load = {
      enable = true,
      name = "project-loaded",
    },
    delete = {
      enable = true,
      name = "project-deleted",
    },
    delete_all = {
      enable = true,
      name = "project-deleted-all",
    },
    merge = {
      enable = true,
      name = "project-merged",
    },
  },
  save = {
    method = "yazi",                        -- yazi | lua
    yazi_load_event = "@projects-load",     -- event name when loading projects in `yazi` method
    lua_save_path = "",                     -- path of saved file in `lua` method, comment out or assign explicitly
    -- default value:
    -- windows: "%APPDATA%/yazi/state/projects.json"
    -- unix: "~/.local/state/yazi/projects.json"
  },
  last = {
    update_after_save = true,
    update_after_load = true,
    update_before_quit = false,
    load_after_start = false,
  },
  merge = {
    event = "projects-merge",
    quit_after_merge = false,
  },
  notify = {
    enable = true,
    title = "Projects",
    timeout = 3,
    level = "info",
  },
})
