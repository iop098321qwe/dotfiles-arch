-- this is a test
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("obsidian")
require("yazi")
require('lspconfig').harper_ls.setup {
  settings = {
    ["harper-ls"] = {
      excludePatterns = {
        "*CHANGELOG*"
      }
    }
  }
}
