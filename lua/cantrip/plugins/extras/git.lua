return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional
    },
    keys = {
      { "<leader>g",  group = "Git" },
      { "<leader>gn", "<cmd>Neogit<CR>", desc = "Neogit" },
    },
    config = true,
  },
  {
    "ldelossa/gh.nvim",
    dependencies = {
      {
        "ldelossa/litee.nvim",
        config = function()
          require("litee.lib").setup()
        end,
      },
    },
    keys = {
      { "<leader>g",    group = "Git" },
      { "<leader>gh",   group = "Github",            desc = "Github" },
      { "<leader>ghc",  group = "Commits",           desc = "Commits" },
      { "<leader>ghcc", "<cmd>GHCloseCommit<cr>",    desc = "Close" },
      { "<leader>ghce", "<cmd>GHExpandCommit<cr>",   desc = "Expand" },
      { "<leader>ghco", "<cmd>GHOpenToCommit<cr>",   desc = "Open To" },
      { "<leader>ghcp", "<cmd>GHPopOutCommit<cr>",   desc = "Pop Out" },
      { "<leader>ghcz", "<cmd>GHCollapseCommit<cr>", desc = "Collapse" },
      { "<leader>ghi",  group = "Issues",            desc = "Issues" },
      { "<leader>ghip", "<cmd>GHPreviewIssue<cr>",   desc = "Preview" },
      { "<leader>ghl",  group = "Litee",             desc = "Litee" },
      { "<leader>ghlt", "<cmd>LTPanel<cr>",          desc = "Toggle Panel" },
      { "<leader>ghp",  group = "Pull Request",      desc = "Pull Request" },
      { "<leader>ghpc", "<cmd>GHClosePR<cr>",        desc = "Close" },
      { "<leader>ghpd", "<cmd>GHPRDetails<cr>",      desc = "Details" },
      { "<leader>ghpe", "<cmd>GHExpandPR<cr>",       desc = "Expand" },
      { "<leader>ghpo", "<cmd>GHOpenPR<cr>",         desc = "Open" },
      { "<leader>ghpp", "<cmd>GHPopOutPR<cr>",       desc = "PopOut" },
      { "<leader>ghpr", "<cmd>GHRefreshPR<cr>",      desc = "Refresh" },
      { "<leader>ghpt", "<cmd>GHOpenToPR<cr>",       desc = "Open To" },
      { "<leader>ghpz", "<cmd>GHCollapsePR<cr>",     desc = "Collapse" },
      { "<leader>ghr",  group = "Review",            desc = "Review" },
      { "<leader>ghrb", "<cmd>GHStartReview<cr>",    desc = "Begin" },
      { "<leader>ghrc", "<cmd>GHCloseReview<cr>",    desc = "Close" },
      { "<leader>ghrd", "<cmd>GHDeleteReview<cr>",   desc = "Delete" },
      { "<leader>ghre", "<cmd>GHExpandReview<cr>",   desc = "Expand" },
      { "<leader>ghrs", "<cmd>GHSubmitReview<cr>",   desc = "Submit" },
      { "<leader>ghrz", "<cmd>GHCollapseReview<cr>", desc = "Collapse" },
      { "<leader>ght",  group = "Threads",           desc = "Threads" },
      { "<leader>ghtc", "<cmd>GHCreateThread<cr>",   desc = "Create" },
      { "<leader>ghtn", "<cmd>GHNextThread<cr>",     desc = "Next" },
      { "<leader>ghtt", "<cmd>GHToggleThread<cr>",   desc = "Toggle" },
    },
    config = function()
      require("litee.gh").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "plenary.nvim", "nvimtools/hydra.nvim" },
    config = function()
      local Hydra = require("hydra")

      local gitsigns = require("gitsigns")

      local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]
      Hydra {
        name = "Git",
        hint = hint,
        config = {
          -- buffer = bufnr,
          color = "pink",
          invoke_on_body = true,
          on_enter = function()
            vim.cmd("mkview")
            vim.cmd("silent! %foldopen!")
            vim.bo.modifiable = false
            gitsigns.toggle_signs(true)
            gitsigns.toggle_linehl(true)
          end,
          on_exit = function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd("loadview")
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            vim.cmd("normal zv")
            gitsigns.toggle_signs(false)
            gitsigns.toggle_linehl(false)
            gitsigns.toggle_deleted(false)
          end,
        },
        mode = { "n", "x" },
        body = "<leader>G",
        heads = {
          {
            "J",
            function()
              if vim.wo.diff then
                return "]c"
              end
              vim.schedule(function()
                gitsigns.next_hunk()
              end)
              return "<Ignore>"
            end,
            { expr = true, desc = "next hunk" },
          },
          {
            "K",
            function()
              if vim.wo.diff then
                return "[c"
              end
              vim.schedule(function()
                gitsigns.prev_hunk()
              end)
              return "<Ignore>"
            end,
            { expr = true, desc = "prev hunk" },
          },
          { "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
          { "u", gitsigns.undo_stage_hunk,   { desc = "undo last stage" } },
          { "S", gitsigns.stage_buffer,      { desc = "stage buffer" } },
          { "p", gitsigns.preview_hunk,      { desc = "preview hunk" } },
          { "d", gitsigns.toggle_deleted,    { nowait = true, desc = "toggle deleted" } },
          { "b", gitsigns.blame_line,        { desc = "blame" } },
          {
            "B",
            function()
              gitsigns.blame_line { full = true }
            end,
            { desc = "blame show full" },
          },
          { "/",       gitsigns.show,     { exit = true, desc = "show base file" } }, -- show the base of the file
          { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
          { "q",       nil,               { exit = true, nowait = true, desc = "exit" } },
        },
      }
    end,
  },
  { "f-person/git-blame.nvim", cmd = { "GitBlameToggle", "GitBlameEnable" } },
}
