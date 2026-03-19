return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
    config = true,
    keys = {
      {
        "<Esc>",
        [[<C-\><C-n>]],
        desc = "Enter Normal mode in Terminal",
        mode = { "t" },
      },
      {
        "<leader>wtv",
        "<cmd>:ToggleTerm size=20 direction=vertical name=terminal<CR>",
        desc = "Open vertical terminal",
        mode = { "n", "o", "x" },
      },
      {
        "<leader><leader>",
        "<cmd>:ToggleTerm size=20 direction=horizontal name=terminal<CR>",
        desc = "Open horizontal terminal",
        mode = { "n", "o", "x" },
      },
    },
  },
}
