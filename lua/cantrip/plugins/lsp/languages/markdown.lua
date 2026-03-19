return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
    },
    init = function()
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  {
    "davidmh/mdx.nvim",
    lazy = true,
    ft = "mdx",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  {
    "stevearc/conform.nvim",
    ---@class ConformOpts
    opts = {
      ---@type table<string, conform.FormatterUnit[]>
      formatters_by_ft = {
        markdown = { "markdownlint-cli2", "mdslw", "cbfmt", lsp_format = "first" },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      anti_conceal = { enabled = false },
      file_types = { "markdown", "opencode_output" },
      completions = { lsp = { enabled = true }, blink = { enabled = true } },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    },
    config = true,
    ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "markdownlint-cli2",
        "cbfmt",
        "marksman",
        "actionlint",
        "mdslw",
        "proselint",
        "vale-ls",
      },
    },
  },
}
