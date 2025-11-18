-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move cursor left in Insert mode (similar to pressing 'h' in Normal mode)
vim.api.nvim_set_keymap(
  'i',
  '<C-h>',
  '<Left>',
  { noremap = true, silent = true, desc = "Move cursor left" })

-- Move cursor right in Insert mode (similar to pressing 'l' in Normal mode)
vim.api.nvim_set_keymap(
  'i',
  '<C-l>',
  '<Right>',
  { noremap = true, silent = true, desc = "Move cursor right" })

-- Normal mode: replace word under cursor with confirmation
vim.api.nvim_set_keymap(
  'n',
  '<leader>i',
  ':%s/\\<<C-r><C-w>\\>//gc<left><left><left>',
  { noremap = true, silent = false, desc = "Replace word under cursor with confirmation" })

-- Visual mode: replace selected text with confirmation
vim.api.nvim_set_keymap(
  'v',
  '<leader>i',
  'y:%s/\\<<C-r>"\\>//gc<left><left><left>',
  { noremap = true, silent = false, desc = "Replace selected text with confirmation" })

-- Add a blank line below the cursor without entering insert mode
vim.api.nvim_set_keymap(
  'n',
  '<leader>o',
  'o<Esc>',
  { noremap = true, silent = true, desc = "Add blank line below" })

-- Add a blank line above the cursor without entering insert mode
vim.api.nvim_set_keymap(
  'n',
  '<leader>O',
  'O<Esc>',
  { noremap = true, silent = true, desc = "Add blank line above" })

-- Toggle relative line numbers
vim.api.nvim_set_keymap(
  'n',
  '<leader>tn',
  ':set relativenumber!<CR>',
  { noremap = true, silent = true, desc = "Toggle relative line numbers" })

-- Duplicate the current line in Normal mode with <leader>D
vim.api.nvim_set_keymap(
  'n',
  '<leader>D',
  'yyp',
  { noremap = true, silent = true, desc = "Duplicate current line" })

-- Duplicate the selected lines in Visual mode with <leader>D
vim.api.nvim_set_keymap('v', '<leader>D', 'y`>p', { noremap = true, silent = true, desc = "Duplicate selected lines" })

-- Yank to system clipboard with yc in Normal mode
vim.api.nvim_set_keymap(
  'n',
  'yc',
  '"+yaw',
  { noremap = true, silent = true, desc = "Yank word under cursor to system clipboard" })

-- Yank to system clipboard with yc in Visual mode
vim.api.nvim_set_keymap(
  'v',
  'yc',
  '"+y',
  { noremap = true, silent = true, desc = "Yank selection to system clipboard" })

-- Yank the current file name (full path) to the system clipboard with yx in Normal mode
vim.api.nvim_set_keymap(
  'n',
  'yp',
  ':let @+=expand("%:p")<CR>',
  { noremap = true, silent = true, desc = "Yank file path to system clipboard" })

-- Yank just the file name to the system clipboard with yx in Normal mode
vim.api.nvim_set_keymap(
  'n',
  'yx',
  ':let @+=expand("%:t")<CR>',
  { noremap = true, silent = true, desc = "Yank file name to system clipboard" })

-- Map 'jj' to function as 'Esc' in Insert mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true, desc = "Map jj to Esc in Insert mode" })

-- Function to toggle auto-commenting on new lines by modifying 'formatoptions'
function ToggleAutoCommenting()
  -- Retrieve the current buffer's 'formatoptions'
  local fo = vim.bo.formatoptions

  -- Check if any of the auto-commenting flags ('c', 'r', 'o') are present
  if fo:find("c") or fo:find("r") or fo:find("o") then
    -- Remove the flags 'c', 'r', and 'o' to disable auto-commenting on new lines
    vim.bo.formatoptions = fo:gsub("[cro]", "")
    print("Auto-commenting on new lines disabled")
  else
    -- Append the flags 'c', 'r', and 'o' to enable auto-commenting on new lines
    vim.bo.formatoptions = fo .. "cro"
    print("Auto-commenting on new lines enabled")
  end
end

-- Map the toggle function to <leader>tc in Normal mode
vim.api.nvim_set_keymap(
  'n',                     -- Normal mode
  '<leader>tc',            -- Key combination: <leader> followed by 'tc'
  ':lua ToggleAutoCommenting()<CR>',  -- Command to execute the function
  { noremap = true, silent = true, desc = "Toggle auto-commenting on new lines" }
)
