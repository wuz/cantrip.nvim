return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      ---@type lazydev.Library.spec[]
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "cantrip.nvim",       words = { "Cantrip" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
        { path = "lazydev.nvim",       words = { "lazydev" } },
        { path = "lazy.nvim",          words = { "Cantrip" } },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  }
}
