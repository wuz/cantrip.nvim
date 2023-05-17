return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-web-devicons" },
    keys = {
      { "<Leader>xx", "<cmd>Trouble<cr>" },
      { "<Leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>" },
      { "<Leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>" },
      { "<Leader>xl", "<cmd>Trouble loclist<cr>" },
      { "<Leader>xq", "<cmd>Trouble quickfix<cr>" },
      { "gR", "<cmd>Trouble lsp_references<cr>" },
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
      local trouble = require("trouble.providers.telescope")
      local extend_opts = vim.tbl_deep_extend("force", opts, {
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        mappings = {
          i = { ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
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
