return {
  {
    "RutaTang/quicknote.nvim",
    opts = {
      mode = "resident",
    },
    event = "BufReadPost",
    init = function()
      local quicknote_path = vim.fn.stdpath("state") .. "/quicknote"
      if not vim.loop.fs_stat(quicknote_path) then
        vim.fn.system({ "mkdir", quicknote_path })
      end
    end,
    config = function(_, opts)
      require("quicknote").setup(opts)
      require("quicknote").ShowNoteSigns()
    end,
    keys = {
      {
        "<leader>qn",
        "<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<cr>",
        desc = "Create a new quick note for current line",
      },
      {
        "<leader>ql",
        "<cmd>:lua require('quicknote').ListNotesForCurrentBuffer()<cr>",
        desc = "List all notes in the current buffer",
      },
      {
        "<leader>qo",
        "<cmd>:lua require('quicknote').OpenNoteAtCurrentLine()<cr>",
        desc = "Open quick note for current line",
      },
      {
        "<leader>qd",
        "<cmd>:lua require('quicknote').DeleteNoteAtCurrentLine()<cr>",
        desc = "Delete quick note for current line",
      },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
