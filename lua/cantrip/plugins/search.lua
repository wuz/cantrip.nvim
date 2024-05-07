return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
    keys = {
      {
        "<leader>xx",
        function()
          require("trouble").toggle()
        end,
      },
      {
        "<leader>xw",
        function()
          require("trouble").toggle("workspace_diagnostics")
        end,
      },
      {
        "<leader>xd",
        function()
          require("trouble").toggle("document_diagnostics")
        end,
      },
      {
        "<leader>xq",
        function()
          require("trouble").toggle("quickfix")
        end,
      },
      {
        "<leader>xl",
        function()
          require("trouble").toggle("loclist")
        end,
      },
      {
        "gR",
        function()
          require("trouble").toggle("lsp_references")
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd({ "BufLeave" }, {
        callback = function()
          local num_windows = vim.fn.winnr("$")
          if num_windows == 1 and vim.bo.filetype == "Trouble" then
            require("trouble").close()
          end
        end,
      })
    end,
    opts = {
      auto_open = true, -- automatically open the list when you have diagnostics
      auto_close = true, -- automatically close the list when you have no diagnostics
    },
  },
  {
    "ggandor/flit.nvim",
    enabled = true,
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   vscode = true,
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = nil,
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<C-P>",
        function()
          require("telescope.builtin").find_files()
        end,
      },
      {
        "<C-N>",
        function()
          require("telescope").extensions.notify.notify()
        end,
      },
      -- {
      --   "<leader>/",
      --   function()
      --     require("telescope").extensions.file_browser.file_browser()
      --   end,
      --   desc = "File Browser",
      -- },
      {
        "<C-M>",
        function()
          require("telescope.builtin").oldfiles()
        end,
      },
      {
        "<C-T>",
        function()
          require("telescope.builtin").tags()
        end,
      },
      {
        "<C-A>",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
      {
        "<C-B>",
        function()
          require("telescope.builtin").buffers()
        end,
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
      },
    },
    opts = {
      pickers = {
        find_files = {
          theme = "dropdown",
        },
        oldfiles = {
          theme = "dropdown",
        },
        tags = {
          theme = "dropdown",
        },
        live_grep = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
        },
        help_tags = {
          theme = "dropdown",
        },
      },
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = " ",
        selection_caret = "● ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.67,
          height = 0.60,
          preview_cutoff = 80,
        },
        file_ignore_patterns = { "node_modules", ".git" },
        path_display = { "smart" },
        winblend = 6,
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          previewer = false,
          cwd = "%:p:h",
          initial_mode = "insert",
          select_buffer = true,
          layout_strategy = "vertical",
          sorting_strategy = "ascending",
          hidden = false,
          git_status = true,
          color_devicons = true,
          use_less = true,
          layout_config = {
            anchor = "W",
            prompt_position = "bottom",
            width = 0.2,
            height = 0.99,
          },
        },
      },
    },
    config = function(_, opts)
      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local extend_opts = vim.tbl_deep_extend("force", opts, {
        defaults = {
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          file_previewer = require("telescope.previewers").cat.new,
          grep_previewer = require("telescope.previewers").vimgrep.new,
          qflist_previewer = require("telescope.previewers").qflist.new,
          mappings = {
            i = { ["<C-T>"] = open_with_trouble },
            n = { ["<C-T>"] = open_with_trouble },
          },
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
        },
      })
      require("telescope").setup(extend_opts)
      require("telescope").load_extension("file_browser")
      local dap_present = pcall(require, "mfussenegger/nvim-dap")
      if dap_present then
        require("telescope").load_extension("dap")
      end
      require("telescope").load_extension("gh")
      vim.cmd([[
   	" Telescope theme support
   	hi link TelescopeBorder LineNr
   	hi link TelescopeMatching Constant
   	hi link TelescopePromptNormal Normal
   	hi link TelescopePromptPrefix Type
   	hi link TelescopeResultsDiffAdd GitGutterAdd
   	hi link TelescopeResultsDiffChange GitGutterChange
   	hi link TelescopeResultsDiffDelete GitGutterDelete
   	hi link TelescopeResultsDiffUntracked Title
   ]])
    end,
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-github.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
}
