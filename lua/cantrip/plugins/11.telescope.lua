return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope").extensions.smart_open.smart_open()
        end,
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files()
        end,
      },
      {
        "<leader>fn",
        function()
          require("telescope").extensions.notify.notify()
        end,
      },
      {
        "<leader>fg",
        function()
          require("telescope").extensions.lazygit.lazygit()
        end,
      },
      {
        "<leader>fm",
        function()
          require("telescope.builtin").oldfiles()
        end,
      },
      {
        "<leader>ft",
        function()
          require("telescope.builtin").tags()
        end,
      },
      {
        "<leader>fa",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
      {
        "<leader>fb",
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
    opts = function()
      local actions = require("telescope.actions")
      local open_with_trouble = require("trouble.sources.telescope").open

      -- Use this to add more results without clearing the trouble list
      local add_to_trouble = require("trouble.sources.telescope").add

      return {
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
          smart_open = {
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
          },
          help_tags = {
            theme = "dropdown",
          },
          lazygit = {
            theme = "dropdown",
          },
        },
        mappings = {
          i = {
            ["<c-t>"] = open_with_trouble,
            ["<c-a>"] = add_to_trouble,
          },
          n = {
            ["<c-t>"] = open_with_trouble,
            ["<c-a>"] = add_to_trouble,
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
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          file_previewer = require("telescope.previewers").cat.new,
          grep_previewer = require("telescope.previewers").vimgrep.new,
          qflist_previewer = require("telescope.previewers").qflist.new,
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
        extensions = {
          smart_open = {
            match_algorithm = "fzy",
            disable_devicons = false,
          },
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
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      local dap_present = pcall(require, "mfussenegger/nvim-dap")
      if dap_present then
        require("telescope").load_extension("dap")
      end
      vim.g.sqlite_clib_path = "/opt/homebrew/opt/sqlite/lib/libsqlite3.dylib"
      require("telescope").load_extension("gh")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("smart_open")
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
      {
        "danielfalk/smart-open.nvim",
        dependencies = {
          "kkharji/sqlite.lua",
          { "nvim-telescope/telescope-fzy-native.nvim" },
        },
      },
    },
  },
}
