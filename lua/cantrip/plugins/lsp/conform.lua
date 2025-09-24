return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = function()
      ---@class ConformOpts
      local opts = {
        default_format_opts = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
        format_on_save = {
          timeout_ms = 3000,
          lsp_fallback = true,
        },
        ---@type table<string, conform.FormatterUnit[]>
        formatters_by_ft = {
          lua = { "stylua", "selene" },
          sh = { "shfmt" },
          kdl = { "kdlfmt" },
          yaml = { "yamlfmt", "actionlint" },
          markdown = { "markdownlint-cli2", "mdslw", "cbfmt", lsp_format = "first" },
        },
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
          injected = { options = { ignore_errors = true } },
          mdslw = { prepend_args = { "--stdin-filepath", "$FILENAME" } },
        },
      }
      return opts
    end,
    config = function(_, opts)
      require("conform").setup(opts)
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
