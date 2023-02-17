return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        event = "InsertEnter",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<Tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<Tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<S-Tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "lspkind-nvim",
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "ray-x/cmp-treesitter" },
      { "quangnguyen30192/cmp-nvim-tags" },
      { "lukas-reineke/cmp-rg" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            },
          }),
          experimental = {
            ghost_text = {
              hl_group = "LspCodeLens",
            },
          },
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            select = true,
          }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "rg" },
          { name = "treesitter" },
          { name = "tags" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
    init = function()
      vim.o.completeopt = "menuone,noselect"
    end,
    config = function(_, opts)
      vim.cmd([[
	" gray
	highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
	" blue
	highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
	highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
	" light blue
	highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
	highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
	highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
	" pink
	highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
	highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
	" front
	highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
	highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
	highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
	]])
      local cmp = require("cmp")
      cmp.setup(opts)

      -- Use buffer source for `/`.
      cmp.setup.cmdline("/", {
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':'.
      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      require("luasnip").filetype_extend("ruby", { "rails" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
}
