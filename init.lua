-- Set leader key first
vim.g.mapleader = " "

-- Basic indentation settings (ADD THESE)
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 2        -- Number of spaces for auto-indent
vim.opt.tabstop = 2           -- Number of spaces a tab counts for
vim.opt.softtabstop = 2       -- Number of spaces for tab in insert mode
vim.opt.autoindent = true     -- Copy indent from current line when starting new line
vim.opt.smartindent = true    -- Smart autoindenting when starting new line
-- Hybrid line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
  },

  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

-- ------------------------------------------------------------------
-- LSP & completion block
-- ------------------------------------------------------------------
{
  "neovim/nvim-lspconfig",
  -- commit = "4266f9bb36b4fb09edd19b67d3563ca3f04fdf26",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local lspconfig  = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Common on_attach for every server
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)

      -- diagnostics pop-ups
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,
                     { desc = "Show line diagnostic" })
      vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist,
                     { desc = "Diagnostics to loclist" })

      -- auto-format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end

    -- TypeScript
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach    = on_attach,
    })

    -- CSS
    lspconfig.cssls.setup({
      capabilities = capabilities,
      on_attach    = on_attach,
    })

    -- nvim-cmp config with limited popup height
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- Window configuration to control popup size
      window = {
        completion = {
          max_height = 10,  -- Maximum height in lines
          max_width = 50,   -- Maximum width in characters (optional)
          scrollbar = true, -- Show scrollbar when needed
        },
        documentation = {
          max_height = 15,  -- Documentation popup height
          max_width = 60,   -- Documentation popup width
        },
      },
      -- Performance settings
      performance = {
        max_view_entries = 20,  -- Limit number of completion items shown
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", max_item_count = 15 },  -- Limit LSP suggestions
        { name = "luasnip", max_item_count = 5 },   -- Limit snippet suggestions
      }, {
        { name = "buffer", max_item_count = 10 },   -- Limit buffer suggestions
        { name = "path", max_item_count = 10 },     -- Limit path suggestions
      }),
    })
  end,
},
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "typescript",
          "javascript",
          "tsx",
          "lua",
          "html",
          "css",
          "json",
          "markdown",
          "markdown_inline",
        },
        highlight = {
          enable = true,
        },
matchup = {
  enable = true,
},
        indent = {
          enable = true,  -- This is important for proper indentation
        },
      })
    end,
  },

  -- Auto-pairs for automatic bracket closing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,  -- Use treesitter for better pairing
        ts_config = {
          lua = {'string'},-- it will not add a pair on that treesitter node
          javascript = {'template_string'},
          java = false,-- don't check treesitter on java
        }
      })
      
      -- Integration with nvim-cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
    --auto-highlighting of matching tags
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = function()
      vim.g.matchup_matchparen_enabled = 1  -- highlight matching tags
      vim.g.matchup_matchparen_offscreen = { method = "popup" } -- shows popup if match is offscreen
    end,
  },


}, {
  -- lazy.nvim options
  rocks = {
    hererocks = false, -- Disable hererocks to avoid the luarocks warnings
  },
})

-- Line moving mappings
-- normal mode
vim.keymap.set('n', '<A-j>', ':m +1<CR>==')  -- Alt-j  → down
vim.keymap.set('n', '<A-k>', ':m -2<CR>==')  -- Alt-k  → up
-- visual mode (works on selected block)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")
