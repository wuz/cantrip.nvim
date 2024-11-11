return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader><leader>",
        function()
          require("telescope.builtin").find_files()
        end,
      },
      {
        "<leader>/n",
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
        "<leader>/m",
        function()
          require("telescope.builtin").oldfiles()
        end,
      },
      {
        "<leader>/t",
        function()
          require("telescope.builtin").tags()
        end,
      },
      {
        "<leader>a",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
      {
        "<leader>/b",
        function()
          require("telescope.builtin").buffers()
        end,
      },
      {
        "<leader>/h",
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
        return require("trouble.sources.telescope").open(...)
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
