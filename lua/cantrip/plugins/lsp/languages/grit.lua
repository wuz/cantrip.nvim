local Cantrip = require("cantrip.utils")

return {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      Cantrip.treesitter.register_language({
        language = "gritql",
        filetypes = {
          grit = "gritql",
        },
        install_info = {
          url = "https://github.com/getgrit/tree-sitter-gritql",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
      })

      return {
        ensure_installed = { "gritql" },
      }
    end,
    -- config = function()
    -- end,
    dependencies = {
      { "getgrit/tree-sitter-gritql" },
    },
  },
}
