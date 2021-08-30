local map = require "utils".map
local termcode = require "utils".termcode
local command = require "utils".command
local cmd = vim.cmd
local fn = vim.fn

local opts = {noremap = true, silent = true}
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

-- map("n", "<C-D>", ":Siblings<CR>", opts)

map(
  "n",
  "<C-P>",
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>",
  noremap
)
map(
  "n",
  "<C-M>",
  "<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown({}))<cr>",
  noremap
)
map(
  "n",
  "<C-T>",
  "<cmd>lua require('telescope.builtin').tags(require('telescope.themes').get_dropdown({}))<cr>",
  noremap
)
map(
  "n",
  "<Leader>a",
  "<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({}))<cr>",
  noremap
)
map(
  "n",
  "<C-B>",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({}))<cr>",
  noremap
)
map(
  "n",
  "<leader>fh",
  "<cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_dropdown({}))<cr>",
  noremap
)

require("telescope").setup(
  {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
      },
      mappings = {
        i = {["<c-t>"] = trouble.open_with_trouble},
        n = {["<c-t>"] = trouble.open_with_trouble}
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
          results_width = 0.8
        },
        vertical = {
          mirror = false
        },
        width = 0.67,
        height = 0.60,
        preview_cutoff = 80
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = {"node_modules", ".git"},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = {"relative"},
      winblend = 0,
      border = {},
      borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      color_devicons = true,
      use_less = true,
      set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new
    }
  }
)
