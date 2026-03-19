return {
  {
    "Juksuu/worktrees.nvim",
    dependencies = { "folke/snacks.nvim", "nvim-lua/plenary.nvim" },
    config = true,
    keys = function()
      local Snacks = require("snacks")
      return {
        {
          "<Leader>Wn",
          function()
            Snacks.picker.worktrees_new()
          end,
          desc = "Worktree:New",
        },
        {
          "<Leader>Ws",
          function()
            Snacks.picker.worktrees()
          end,
          desc = "Worktree:Switch",
        },
        {
          "<Leader>Wr",
          function()
            Snacks.picker.worktrees_remove()
          end,
          desc = "Worktree:Remove",
        },
      }
    end,
  },
}
