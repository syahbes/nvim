-- ~/.config/nvim/lua/config/options.lua
-- Core Neovim options and settings
-- These settings configure how Neovim behaves

-- Indentation settings
-- expandtab: Use spaces instead of tab characters
vim.opt.expandtab = true
-- shiftwidth: Number of spaces to use for each step of auto-indent
vim.opt.shiftwidth = 2
-- tabstop: Number of spaces that a tab character in the file counts for
vim.opt.tabstop = 2
-- softtabstop: Number of spaces that a tab counts for while editing
vim.opt.softtabstop = 2
-- autoindent: Copy indent from current line when starting a new line
vim.opt.autoindent = true
-- smartindent: Smart autoindenting when starting a new line (useful for code)
vim.opt.smartindent = true

-- Line number settings
-- number: Show absolute line numbers
vim.opt.number = true
-- relativenumber: Show relative line numbers (makes navigation easier)
vim.opt.relativenumber = true
