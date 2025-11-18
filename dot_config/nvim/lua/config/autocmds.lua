-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable auto-commenting on new lines
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set formatoptions-=cro",
  desc = "Disable auto-commenting on new lines",
})

-- Restore cursor position when reopening file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line
    if line("'\"") > 1 and line("'\"") <= line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
  desc = "Restore cursor position when reopening file",
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
  desc = "Highlight yanked text",
})

-- Automatically fold all folds on file open
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd("normal! zM") -- Fold all folds
  end,
  desc = "Automatically fold all folds on file open",
})

-- Set foldmethod to indent for HTML files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt_local.foldmethod = "indent"
  end,
  desc = "Set foldmethod to indent for HTML files",
})
