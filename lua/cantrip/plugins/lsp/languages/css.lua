return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css",
        "scss",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "stylelint",
        "css-lsp",
        "css-variables-language-server",
      },
    },
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
    opts = {
      formatters_by_ft= {
        css = { "biome", lsp_format = "first" }
      }
    }
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
