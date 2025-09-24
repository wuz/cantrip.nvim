return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "css", "scss" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "biome",
          "stylelint",
          "css-lsp",
          "css-variables-language-server",
        })
      end
    end,
  },
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    lazy = true,
    keys = {
      { "<leader>cp", ":Colortils<CR>", desc = "Open color picker" },
    },
    opts = {
      default_format = "rgb",
    },
    config = true,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.css = { "biome", lsp_format = "first" }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
        css_variables = {},
        biome = {
          settings = {
            enable = true,
          },
        },
      },
    },
  },
}
