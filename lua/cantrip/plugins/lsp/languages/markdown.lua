return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        extension = {
          mdx = "mdx",
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
      local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
      ft_to_parser.mdx = "markdown"

      require("vim.treesitter.query").set_query(
        "markdown",
        "injections",
        '((inline) @_inline (#match? @_inline "^(import|export)")) @tsx'
      )

      require("vim.treesitter.query").set_query(
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
        })
      end
    end,
  },
}
