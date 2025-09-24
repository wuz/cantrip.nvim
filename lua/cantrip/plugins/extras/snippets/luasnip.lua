return {
  -- disable builtin snippet support
  { "garymjr/nvim-snippets", enabled = false },

  -- add luasnip
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = "make install_jsregexp",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip").filetype_extend("ruby", { "rails" })
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_lua").lazy_load { paths = { vim.fn.stdpath("config") .. "/snippets" } }
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      enable_autosnippets = true,
    },
  },
  -- blink.cmp + luasnip
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        preset = "luasnip",
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources.default = vim.tbl_filter(function(p)
        return p ~= "snippets"
      end, opts.sources.default)
    end,
  },
}
