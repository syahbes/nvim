-- ~/.config/nvim/init.lua
-- Main configuration entry point for Neovim
-- This file loads all other configuration modules

-- Set leader key first (this must be done before loading plugins)
-- Leader key is used as a prefix for custom key mappings
vim.g.mapleader = " "

-- Load core Neovim settings (options, basic configs)
require("config.options")

-- Bootstrap and configure the lazy.nvim plugin manager
require("config.lazy")

-- Load custom key mappings
require("config.keymaps")
