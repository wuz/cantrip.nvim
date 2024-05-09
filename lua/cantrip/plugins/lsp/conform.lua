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
        "<leader>F",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = function()
      local plugin = require("lazy.core.config").plugins["conform.nvim"]
      ---@class ConformOpts
      local opts = {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        format = {
          timeout_ms = 3000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 3000,
          lsp_fallback = true,
        },
        ---@type table<string, conform.FormatterUnit[]>
        formatters_by_ft = {
          lua = { { "stylua" } },
          fish = { { "fish_indent" } },
          sh = { { "shfmt" } },
          javascript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          graphql = { { "prettierd", "prettier" } },
        },
        -- The options you set here will be merged with the builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
          injected = { options = { ignore_errors = true } },
          -- # Example of using dprint only when a dprint.json file is present
          -- dprint = {
          --   condition = function(ctx)
          --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          --   end,
          -- },
          --
          -- # Example of using shfmt with extra args
          -- shfmt = {
          --   prepend_args = { "-i", "2", "-ci" },
          -- },
        },
      }
      return opts
    end,
    config = function(_, opts)
      require("conform").setup(opts)
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,

    -- opts = {
    --   formatters_by_ft = {
    --   },
    --   format_on_save = {
    --     lsp_fallback = true,
    --     timeout_ms = 2000,
    --   },
    -- },
  },
}

-- {
--   "nvimtools/none-ls.nvim",
--   event = { "BufReadPre", "BufNewFile" },
--   cmd = { "NullLsInstall", "NullLsUninstall", "NullLsLog", "NullLsInfo" },
--   dependencies = { "mason.nvim" },
-- },
-- {
--   "jay-babu/mason-null-ls.nvim",
--   dependencies = {
--     "mason.nvim",
--     "none-ls.nvim",
--   },
--   build = ":MasonUpdate",
--   opts = function()
--     local null_ls = require("null-ls")
--     return {
--       ensure_installed = {
--         "rubocop",
--         "stylua",
--         "write_good",
--         "rubocop",
--         "stylelint",
--         -- "eslint_d",
--         "statix",
--         "nixfmt",
--         "markdownlint",
--         "shellharden",
--         "shfmt",
--         "gitrebase",
--       },
--       handlers = {
--         function(source_name, methods)
--           require("mason-null-ls.automatic_setup")(source_name, methods)
--         end,
--         reek = function(source_name, methods)
--           local reek = require("cantrip.plugins.lsp.formatters.reek")
--           null_ls.register(reek)
--         end,
--         -- eslint_d = function()
--         --   null_ls.register({
--         --     null_ls.builtins.diagnostics.eslint_d,
--         --   })
--         -- end,
--         statix = function()
--           null_ls.register({
--             null_ls.builtins.code_actions.statix,
--             null_ls.builtins.diagnostics.statix,
--           })
--         end,
--       },
--     }
--   end,
-- },
