local map = require("utils").map
local trouble = require("trouble.providers.telescope")

local noremap = { noremap = true }

map("n", "<C-P>", "<cmd>lua require('telescope.builtin').find_files()<cr>", noremap)

map("n", "<C-N>", "<cmd>lua require('telescope').extensions.notify.notify()<cr>", noremap)
map("n", "<C-M>", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", noremap)
map("n", "<C-T>", "<cmd>lua require('telescope.builtin').tags()<cr>", noremap)

map("n", "<C-A>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", noremap)

map("n", "<C-B>", "<cmd>lua require('telescope.builtin').buffers()<cr>", noremap)
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", noremap)

require("telescope").setup({
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
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
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
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules", ".git" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { "relative" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
})

require("telescope").load_extension("packer")
require("telescope").load_extension("dap")
require("telescope").load_extension("gh")

vim.cmd([[
" Telescope support
hi link TelescopeBorder LineNr
hi link TelescopeMatching Constant
hi link TelescopePromptNormal Normal
hi link TelescopePromptPrefix Type
hi link TelescopeResultsDiffAdd GitGutterAdd
hi link TelescopeResultsDiffChange GitGutterChange
hi link TelescopeResultsDiffDelete GitGutterDelete
hi link TelescopeResultsDiffUntracked Title
]])
