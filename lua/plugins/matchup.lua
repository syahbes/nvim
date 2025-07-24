-- ~/.config/nvim/lua/plugins/matchup.lua
-- vim-matchup: Enhanced matching for brackets, tags, and keywords
-- Highlights matching HTML tags, if/endif pairs, etc.

return {
  "andymass/vim-matchup",
  -- event: Load when Neovim has finished starting (lazy loading)
  event = "VeryLazy",
  config = function()
    -- Enable highlighting of matching parentheses/brackets/tags
    vim.g.matchup_matchparen_enabled = 1
    
    -- Show popup if the matching pair is off-screen
    -- This helps you see what you're matching when the pair is not visible
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}
