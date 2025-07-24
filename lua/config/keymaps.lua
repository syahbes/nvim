-- ~/.config/nvim/lua/config/keymaps.lua
-- Custom key mappings for enhanced productivity
-- These keymaps allow you to move lines up and down easily

-- Line moving mappings using Alt key
-- These mappings allow you to move lines or blocks of code up and down

-- Normal mode line movement
-- Alt-j: Move current line down one position
vim.keymap.set('n', '<A-j>', ':m +1<CR>==')
-- Alt-k: Move current line up one position  
vim.keymap.set('n', '<A-k>', ':m -2<CR>==')

-- Visual mode line movement (works on selected blocks)
-- Alt-j: Move selected block down one position
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
-- Alt-k: Move selected block up one position
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Explanation of the commands:
-- :m +1 = move line down by 1
-- :m -2 = move line up by 1 (relative to current position)
-- == = re-indent the line after moving
-- gv = reselect the previously selected text
-- =gv = re-indent and reselect the moved block
