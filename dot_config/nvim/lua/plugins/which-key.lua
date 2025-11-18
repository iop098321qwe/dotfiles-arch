-- ~/.config/nvim/lua/plugins/which-key.lua
return {
  {
    "folke/which-key.nvim",
    -- Ensure which-key is loaded before we add mappings
    event = "VeryLazy",
    config = function(_, opts)
      -- If LazyVim or another layer passes opts, set them first then add
      require("which-key").setup(opts or {})

      -----------------------------------------------------------------------
      -- REGISTERS: helper functions
      -----------------------------------------------------------------------
      local function PasteRegister()
        local reg = vim.fn.input("Paste register: ")
        if reg == "" then
          print("No register specified")
          return
        end
        -- :put {reg} pastes after the current line in normal mode
        vim.cmd("put " .. reg)
      end

      local function YankLineToRegister()
        local reg = vim.fn.input("Yank current line to register: ")
        if reg == "" then
          print("No register specified")
          return
        end
        -- Use yy (yank line) instead of dd (delete line)
        vim.cmd('normal! "' .. reg .. 'yy')
        print('Current line yanked into register "' .. reg .. '".')
      end

      local wk = require("which-key")

      -----------------------------------------------------------------------
      -- OBSIDIAN group + mappings (NORMAL)
      -----------------------------------------------------------------------
      wk.add({
        { "<leader>fo",  group = "Obsidian" },
        { "<leader>foD", "<cmd>ObsidianDebug<CR>",    desc = "Debug" },
        { "<leader>foc", "<cmd>ObsidianCheck<CR>",    desc = "Check" },
        { "<leader>fod", "<cmd>ObsidianDailies<CR>",  desc = "Dailies" },
        { "<leader>foi", "<cmd>ObsidianPasteImg<CR>", desc = "Paste Image" },
        { "<leader>fot", "<cmd>ObsidianTemplate<CR>", desc = "Template" },
      }, {
        mode = "n",
        silent = true,  -- vim.keymap.set is noremap by default; silent keeps cmdline clean
      })

      -----------------------------------------------------------------------
      -- REGISTERS group + mappings (NORMAL)
      -----------------------------------------------------------------------
      wk.add({
        { "<leader>R",  group = "Registers" },
        { "<leader>Rh", PasteRegister,      desc = "Paste register contents" },
        { "<leader>RH", YankLineToRegister, desc = "Yank line into register" },
      }, {
        mode = "n",
        silent = true,
      })

      -----------------------------------------------------------------------
      -- MOVE LINE DOWN/UP (NORMAL + VISUAL)
      -----------------------------------------------------------------------
      -- Normal-mode: use <cmd> for cleaner execution and to avoid lag
      wk.add({
        { "<leader>j", "<cmd>m .+1<CR>==", desc = "Move line down" },
        { "<leader>k", "<cmd>m .-2<CR>==", desc = "Move line up"   },
      }, {
        mode = "n",
        silent = true,
      })

      -- Visual-mode: keep raw Ex commands to preserve visual selection marks
      wk.add({
        { "<leader>j", ":m '>+1<CR>gv=gv", desc = "Move selection down", mode = "v" },
        { "<leader>k", ":m '<-2<CR>gv=gv", desc = "Move selection up",   mode = "v" },
      }, {
        silent = true,
      })
    end,
  },
}
