return {
  { "antoinemadec/FixCursorHold.nvim" },
  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "echasnovski/mini.sessions",
    version = false,
    config = function()
      require("mini.sessions").setup()
    end,
  },
  {
    "nguyenvukhang/nvim-toggler",
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoLocList", "TodoTelescope", "TodoQuickFix" },
  },
}
