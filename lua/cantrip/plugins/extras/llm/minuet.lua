return {
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- blink = {
      --   enable_auto_complete = true,
      -- },
      provider = "openai_fim_compatible",
      notify = "error",
      provider_options = {
        openai_fim_compatible = {
          model = "deepseek-coder-v2",
          end_point = "http://localhost:11434/v1/completions",
          name = "Deepseek",
          api_key = "LANG",
          stream = true,
          max_tokens = 512,
          optional = {
            stop = nil,
            max_tokens = nil,
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependences = {
      "milanglacier/minuet-ai.nvim",
    },
    opts = {
      sources = {
        default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
