return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "lua" })
      end
    end,
  },
  {
    "folke/lazydev.nvim",
    dependencies = { "justinsgithub/wezterm-types" },
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "cantrip.nvim",
        { path = "LazyVim",            words = { "LazyVim" } },
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "wezterm-types",      mods = { "wezterm" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {                                        -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {},
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "lua-languange-server",
          "selene",
          "stylua",
        })
      end
    end,
  },
}
