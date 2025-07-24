-- ~/.config/nvim/lua/plugins/treesitter.lua
-- Tree-sitter: Advanced syntax highlighting and code understanding
-- Provides better syntax highlighting, indentation, and text objects

return {
  "nvim-treesitter/nvim-treesitter",
  -- build: Command to run after installing/updating the plugin
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Languages to install parsers for
      -- Parsers are what tree-sitter uses to understand different file types
      ensure_installed = {
        "typescript",      -- TypeScript files (.ts)
        "javascript",      -- JavaScript files (.js)
        "tsx",            -- TypeScript React files (.tsx)
        "lua",            -- Lua files (for Neovim config)
        "html",           -- HTML files
        "css",            -- CSS files
        "json",           -- JSON files
        "markdown",       -- Markdown files (.md)
        "markdown_inline", -- Inline markdown (for code blocks)
      },
      -- Enable improved syntax highlighting
      highlight = {
        enable = true,  -- Enable tree-sitter based highlighting
      },
      -- Enable matchup integration (for matching tags/brackets)
      matchup = {
        enable = true,  -- Works with vim-matchup plugin
      },
      -- Enable improved indentation
      indent = {
        enable = true,  -- Enable tree-sitter based indentation (important!)
      },
    })
  end,
}
