return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "nix" })
      end
    end,
  },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     if type(opts.ensure_installed) == "table" then
  --       vim.list_extend(opts.ensure_installed, {
  --         "nil",
  --       })
  --     end
  --   end,
  -- },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.nix = { "nixfmt" }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "LnL7/vim-nix" },
    opts = {
      servers = {
        nixd = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    },
  },
}
