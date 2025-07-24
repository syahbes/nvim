-- ~/.config/nvim/lua/plugins/autopairs.lua
-- nvim-autopairs: Automatically insert closing brackets, quotes, etc.
-- When you type '(' it automatically adds ')' and positions cursor between them

return {
  "windwp/nvim-autopairs",
  -- event: Only load this plugin when entering insert mode (lazy loading)
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      -- check_ts: Use tree-sitter for better bracket pairing decisions
      check_ts = true,
      -- ts_config: Tree-sitter specific configuration for different languages
      ts_config = {
        lua = {'string'},           -- Don't add pairs inside lua strings
        javascript = {'template_string'}, -- Don't add pairs inside JS template strings
        java = false,               -- Don't check tree-sitter for java files
      }
    })
    
    -- Integration with nvim-cmp (completion engine)
    -- This ensures autopairs works correctly with completion
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    -- When a completion item is confirmed, trigger autopairs if needed
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
