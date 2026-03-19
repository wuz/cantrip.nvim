return {
  {
    "echasnovski/mini.tabline",
    version = false,
    config = true,
    lazy = true,
    keys = {
      { "<M-h>", "<cmd>bprev<cr>", desc = "Prev buffer" },
      { "<M-l>", "<cmd>bnext<cr>", desc = "Next buffer" },
      { "[b",    "<cmd>bprev<cr>", desc = "Prev buffer" },
      { "]b",    "<cmd>bnext<cr>", desc = "Next buffer" },
    },
  },
}