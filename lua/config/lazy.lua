-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap and configure the lazy.nvim plugin manager
-- lazy.nvim is a modern plugin manager for Neovim

-- Define the path where lazy.nvim will be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is already installed
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  -- Clone lazy.nvim from GitHub if it's not installed
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none", -- Partial clone for faster download
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Use the stable branch
    lazypath,
  })
end

-- Add lazy.nvim to the runtime path so it can be required
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim and load all plugins from the plugins directory
require("lazy").setup("plugins", {
  -- lazy.nvim configuration options
  rocks = {
    -- Disable hererocks to avoid luarocks warnings
    hererocks = false,
  },
})
