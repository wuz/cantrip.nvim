local Cantrip = require("cantrip.utils")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "rust" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "rust-analyzer",
          "bacon-ls",
        })
      end
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },
    },
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        rust_analyzer = {
          checkOnSave = {
            command = "clippy",
          },
        },
        bacon_ls = {},
      },
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {},
    },
  },
}
