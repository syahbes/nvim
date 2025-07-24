-- ~/.config/nvim/lua/plugins/telescope.lua
-- Telescope: A highly extendable fuzzy finder over lists
-- Used for finding files, searching text, and much more

return {
  "nvim-telescope/telescope.nvim",
  -- Dependencies: plugins that telescope needs to function
  dependencies = { "nvim-lua/plenary.nvim" },
  -- Lazy loading: only load when these keys are pressed
  keys = {
    -- <leader>ff: Find files in current directory
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    -- <leader>fg: Live grep (search for text in files)
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  },
}
