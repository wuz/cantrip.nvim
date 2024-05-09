return {
  -- Comments
  {
    "echasnovski/mini.comment",
    version = false,
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoLocList", "TodoTelescope", "TodoQuickFix" },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
    },
    opts = {
      gui_style = {
        fg = "NONE",                         -- The gui style to use for the fg highlight group.
        bg = "BOLD",                         -- The gui style to use for the bg highlight group.
      },
      pattern = [[\b(KEYWORDS)(\(\w*\))?:]], -- ripgrep regex
    },
    config = true,
  },
  -- / Comments
  -- Highlight traling spaces
  {
    "echasnovski/mini.trailspace",
    version = false,
    config = true,
  },
  -- Surround code
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gza",            -- Add surrounding in Normal and Visual modes
        delete = "gzd",         -- Delete surrounding
        find = "gzf",           -- Find surrounding (to the right)
        find_left = "gzF",      -- Find surrounding (to the left)
        highlight = "gzh",      -- Highlight surrounding
        replace = "gzr",        -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },
  -- Toggle between values
  {
    "nguyenvukhang/nvim-toggler",
    config = true,
  },
  -- Align items
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)" },
    },
  },
}
