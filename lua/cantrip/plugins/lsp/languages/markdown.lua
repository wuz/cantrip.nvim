return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "markdown",
          "markdown_inline",
        })
      end
    end,
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
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
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
    ft = "markdown",
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "markdownlint-cli2",
          "cbfmt",
          "marksman",
          "mdslw",
          "proselint",
          "vale-ls",
        })
      end
    end,
  },
}
