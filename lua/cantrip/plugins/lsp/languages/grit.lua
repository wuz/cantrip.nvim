return {

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.parsers").get_parser_configs().gritql = {
        install_info = {
          url = "https://github.com/getgrit/tree-sitter-gritql",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "gritql",
      }
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        ensure_installed = {
          "gritql",
        },
      }
      vim.filetype.add {
        extension = {
          grit = "gritql",
        },
      }
    end,
    dependencies = {
      { "getgrit/tree-sitter-gritql" },
    },
    build = ":TSUpdate",
  },
}
