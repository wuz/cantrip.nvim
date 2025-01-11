return {
  {
    "brenoprata10/nvim-highlight-colors",
    optional = true,
    enabled = false,
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      css = { css = true },
      lua = { css = true },
      typescript = { css = true },
      javascript = { css = true },
      typescriptreact = { css = true },
      javascriptreact = { css = true },
      html = { css = true },
    },
  },
}
