return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    -- Set the path to your Obsidian vault.
    workspaces = {
      {
        name = "grymms_grimoires",
        path = "~/Documents/grymms_grimoires",
      },
    },
    -- Set the template directory.
    templates = {
      folder = "99000_other/99800_templates",
      date_format = "%Y.%m.%d-%A",
      time_format = "%H:%M",
    },
    -- Set the completion options.
    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },
    -- Open app foreground options.
    open_app_foreground = true,
    -- Set the picker options.
    picker = {
      name = "fzf-lua",
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "99000_other/99100_daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y.%m.%d-%A",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily_notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil
    },
    attachments = {
      img_folder = "99000_other/99600_attachments/images",

      ---@return string
      img_name_func = function()
        return string.format("%s-", os.time())
      end,

      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
  },
}
