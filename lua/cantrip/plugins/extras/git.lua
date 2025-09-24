return {
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  { "sindrets/diffview.nvim", config = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "git_config", "gitcommit", "git_rebase", "gitignore", "gitattributes" } },
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "plenary.nvim", "nvimtools/hydra.nvim" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(buffer)
        local Hydra = require("hydra")

        local gitsigns = package.loaded.gitsigns

        local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^                    _q_: exit
]]
        Hydra({
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
            { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
            { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
            { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
            { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
            { "b", gitsigns.blame_line, { desc = "blame" } },
            {
              "B",
              function()
                gitsigns.blame_line({ full = true })
              end,
              { desc = "blame show full" },
            },
            { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
            { "q", nil, { exit = true, nowait = true, desc = "exit" } },
          },
        })
      end,
    },
    config = function() end,
  },
  {
    "gitsigns.nvim",
    opts = function()
      local Snacks = require("snacks")
      Snacks.toggle({
        name = "Git Signs",
        get = function()
          return require("gitsigns.config").config.signcolumn
        end,
        set = function(state)
          require("gitsigns").toggle_signs(state)
        end,
      }):map("<leader>uG")
    end,
  },
  { "f-person/git-blame.nvim", cmd = { "GitBlameToggle", "GitBlameEnable" } },
  -- better git commit editing
  {
    "rhysd/committia.vim",
    ft = "gitcommit",
  },
}
