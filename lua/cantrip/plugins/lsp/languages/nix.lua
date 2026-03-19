return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "nix",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        nix = { "statix" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "LnL7/vim-nix" },
    opts = {
      servers = {
        nil_ls = {},
        nixd = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    },
  },
}
