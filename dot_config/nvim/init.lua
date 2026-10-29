-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("obsidian")
require("yazi")
require('lspconfig').harper_ls.setup {
  -- Avoid a broken-stderr panic on shutdown: Automattic/harper#4734.
  -- Undo record: ~/.local/state/nvim/harper-stderr-workaround/README.md
  cmd = {
    "/bin/sh",
    "-c",
    'umask 077; exec /usr/bin/harper-ls --stdio 2>>"$1"',
    "harper-ls",
    vim.fn.stdpath("state") .. "/harper-ls.stderr.log",
  },
  settings = {
    ["harper-ls"] = {
      excludePatterns = {
        "*CHANGELOG*"
      }
    }
  }
}
require("octo")
