return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<Leader>?", ":CodeCompanionChat<CR>", desc = "Open Code Companion" },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "coder",
        },
        inline = {
          adapter = "coder",
        },
      },
      adapters = {
        coder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "coder", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = "deepseek-coder-v2",
              },
            },
          })
        end,
      },
    },
    config = true,
  },
  { "MeanderingProgrammer/render-markdown.nvim", ft = { "codecompanion" } },
  {
    "saghen/blink.cmp",
    optional = true,
    dependences = {
      "olimorris/codecompanion.nvim",
    },
    opts = {
      sources = {
        default = { "codecompanion" },
        providers = {
          codecompanion = {
            name = "codecompanion",
            module = "codecompanion.providers.completion.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
