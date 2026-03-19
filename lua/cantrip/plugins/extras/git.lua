return {
  { "tronikelis/conflict-marker.nvim", config = true },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "Kaiser-Yang/blink-cmp-git",
      },
    },
    opts = {
      sources = {
        -- add 'git' to the list
        default = { "git" },
        providers = {
          git = {
            module = "blink-cmp-git",
            name = "Git",
            opts = {
              -- options for the blink-cmp-git
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "git_config", "gitcommit", "git_rebase", "gitignore", "gitattributes" } },
  },
  {
    "sindrets/diffview.nvim",
    opts = function()
      local actions = require("diffview.actions")
      return {
        enhanced_diff_hl = true,
        file_panel = {
          listing_style = "list",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
          },
          merge_tool = {
            layout = "diff1_plain",
          },
        },
        default_args = {
          DiffviewOpen = { "--imply-local" },
        },
        hooks = {
          diff_buf_win_enter = function(bufnr, winid, ctx)
            if ctx.layout_name:match("^diff2") then
              if ctx.symbol == "a" then
                vim.opt_local.winhl = table.concat({
                  "DiffAdd:DiffviewDiffAddAsDelete",
                  "DiffDelete:DiffviewDiffDelete",
                }, ",")
              elseif ctx.symbol == "b" then
                vim.opt_local.winhl = table.concat({
                  "DiffDelete:DiffviewDiffDelete",
                }, ",")
              end
            end
            vim.wo[winid].culopt = "number"
          end,
        },
        keymaps = {
          file_history_panel = {
            ["q"] = actions.close,
          },
          view = {
            -- instead of cycle through another buffer, move around window
            ["<tab>"] = "<Cmd>wincmd w<CR>",
            -- instead of closing one buffer, do `DiffviewClose`
            ["q"] = actions.close,
          },
          file_panel = {
            -- just select them when moving
            ["j"] = actions.select_next_entry,
            ["k"] = actions.select_prev_entry,
            ["<down>"] = actions.select_next_entry,
            ["<up>"] = actions.select_prev_entry,
            -- all of them to just go to the diff2 (right panel) so you can edit right at the Diffview tab
            ["gf"] = actions.focus_entry,
            ["<tab>"] = actions.focus_entry,
            ["<cr>"] = actions.focus_entry,
            ["e"] = actions.focus_entry,
            ["h"] = actions.toggle_flatten_dirs,
            ["l"] = actions.focus_entry,
            -- instead of closing one buffer, do `DiffviewClose`
            ["q"] = ":tabc<cr>",
          },
        },
      }
    end,
    config = function(_, opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "DiffviewViewLeave",
        callback = function()
          vim.cmd(":DiffviewClose")
        end,
      })
      require("diffview").setup(opts)
    end,
  },
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
          body = "<leader>gG",
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
    config = true,
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
      }):map("<leader>gU")
    end,
  },
  -- better git commit editing
  {
    "rhysd/committia.vim",
    ft = "gitcommit",
  },
}
