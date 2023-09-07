return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        extension = {
          mdx = "markdown",
        },
      })
    end,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "markdown",
          "markdown_inline",
        })
      end

      -- vim.treesitter.language.register("markdown", "markdown.mdx")
      -- vim.treesitter.language.register("markdown_inline", "markdown.mdx")

      vim.treesitter.query.set(
        "markdown",
        "injections",
        '((inline) @_inline (#match? @_inline "^(import|export)")) @tsx'
      )

      vim.treesitter.query.set(
        "markdown",
        "highlights",
        '((inline) @_inline (#match? @_inline "^(import|export)")) @nospell'
      )
    end,
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "markdownlint",
          "cbfmt",
          "marksman",
          "prettier",
        })
      end
    end,
  },
}
