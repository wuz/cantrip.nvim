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
      vim.cmd("autocmd BufLeave <buffer> lua print(vim.fn.winnr('$'))")
    end,
    opts = {
      auto_open = true, -- automatically open the list when you have diagnostics
      auto_close = true, -- automatically close the list when you have no diagnostics
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<C-P>", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
      { "<C-N>", "<cmd>lua require('telescope').extensions.notify.notify()<cr>" },
      { "<C-M>", "<cmd>lua require('telescope.builtin').oldfiles()<cr>" },
      { "<C-T>", "<cmd>lua require('telescope.builtin').tags()<cr>" },
      { "<C-A>", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
      { "<C-B>", "<cmd>lua require('telescope.builtin').buffers()<cr>" },
      { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
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
        path_display = { "relative" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
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
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-github.nvim",
    },
  },
}
