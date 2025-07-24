-- ~/.config/nvim/lua/plugins/lsp.lua
-- LSP (Language Server Protocol) configuration
-- Provides IDE-like features: autocomplete, go-to-definition, error checking, etc.

return {
  "neovim/nvim-lspconfig",
  -- Dependencies: All the plugins needed for LSP functionality
  dependencies = {
    "hrsh7th/nvim-cmp",        -- Completion engine
    "hrsh7th/cmp-nvim-lsp",    -- LSP completion source
    "hrsh7th/cmp-buffer",      -- Buffer completion source
    "hrsh7th/cmp-path",        -- Path completion source
    "L3MON4D3/LuaSnip",        -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Snippet completion source
  },
  config = function()
    local lspconfig = require("lspconfig")
    -- Get enhanced capabilities from nvim-cmp for better completion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Common function that runs when any LSP server attaches to a buffer
    -- This sets up keymaps and autocommands for LSP features
    local on_attach = function(client, bufnr)
      -- opts: options for keymap (scoped to current buffer)
      local opts = { buffer = bufnr }

      -- LSP Navigation keymaps
      -- gd: Go to definition (jump to where something is defined)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      -- K: Show hover information (documentation popup)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      -- <leader>rn: Rename symbol under cursor
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      -- <leader>ca: Code actions (quick fixes, refactoring options)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      -- gr: Go to references (find all usages)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      -- <leader>f: Format current buffer
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)

      -- Diagnostic keymaps (for showing errors/warnings)
      -- <leader>e: Show diagnostics for current line in floating window
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float,
                     { desc = "Show line diagnostic" })
      -- <leader>E: Show all diagnostics in location list
      vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist,
                     { desc = "Diagnostics to loclist" })

      -- Auto-format on save
      -- This automatically formats your code when you save the file
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end

    -- Setup LSP servers
    -- TypeScript/JavaScript language server
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        typescript = {
          format = {
            semicolons = "insert",  -- Always insert semicolons
          },
          preferences = {
            quoteStyle = "single",  -- Optional: use single quotes
          },
        },
        javascript = {
          format = {
            semicolons = "insert",  -- Always insert semicolons
          },
          preferences = {
            quoteStyle = "single",  -- Optional: use single quotes
          },
        },
      },
    })

    -- CSS language server
    lspconfig.cssls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- nvim-cmp setup (completion engine configuration)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      -- Snippet configuration
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- Window configuration to control popup appearance and size
      window = {
        completion = {
          max_height = 10,  -- Maximum height of completion popup (in lines)
          max_width = 50,   -- Maximum width of completion popup (in characters)
          scrollbar = true, -- Show scrollbar when content overflows
        },
        documentation = {
          max_height = 15,  -- Maximum height of documentation popup
          max_width = 60,   -- Maximum width of documentation popup
        },
      },
      -- Performance settings to prevent lag
      performance = {
        max_view_entries = 20,  -- Limit number of completion items shown at once
      },
      -- Key mappings for completion popup
      mapping = cmp.mapping.preset.insert({
        -- Ctrl-b: Scroll documentation popup up
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- Ctrl-f: Scroll documentation popup down
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Ctrl-Space: Trigger completion manually
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Ctrl-e: Close completion popup
        ["<C-e>"] = cmp.mapping.abort(),
        -- Enter: Confirm selected completion item
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- Tab: Navigate completion items or expand snippets
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
      -- Completion sources (where suggestions come from)
      sources = cmp.config.sources({
        -- Primary sources (higher priority)
        { name = "nvim_lsp", max_item_count = 15 },  -- LSP suggestions (limited to 15)
        { name = "luasnip", max_item_count = 5 },   -- Snippet suggestions (limited to 5)
      }, {
        -- Secondary sources (lower priority, used when primary sources don't match)
        { name = "buffer", max_item_count = 10 },   -- Text from current buffer
        { name = "path", max_item_count = 10 },     -- File path suggestions
      }),
    })
  end,
}
