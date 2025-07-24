-- ~/.config/nvim/lua/plugins/catppuccin.lua
-- Catppuccin: A soothing pastel theme for Neovim
-- Provides beautiful syntax highlighting and UI colors

return {
  "catppuccin/nvim",
  name = "catppuccin",
  -- priority: Load this plugin first (colorschemes should load early)
  priority = 1000,
  -- config: Function that runs when the plugin is loaded
  config = function()
    -- Setup catppuccin with custom configuration
    require("catppuccin").setup({
      -- flavour: Choose the color variant (mocha is the darkest)
      -- Available flavours: latte, frappe, macchiato, mocha
      flavour = "mocha",
    })
    -- Apply the colorscheme immediately after setup
    vim.cmd.colorscheme("catppuccin")
  end,
}
