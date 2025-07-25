-- lua/plugins/gitFugitive.lua
return {
  "tpope/vim-fugitive",
  cmd = {
    "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep",
    "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit"
  },
  ft = {"fugitive"},
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    { "<leader>gl", "<cmd>Git log<cr>", desc = "Git log" },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
    { "<leader>gP", "<cmd>Git pull<cr>", desc = "Git pull" },
  },
}
