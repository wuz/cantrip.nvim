local map = require "utils".map
local termcode = require "utils".termcode
local command = require "utils".command
local cmd = vim.cmd
local fn = vim.fn

local opts = {noremap = true, silent = true}

-- map("n", "<C-P>", ":Files<CR>", opts)
-- map("n", "<C-T>", ":Tags<CR>", opts)
-- map("n", "<C-M>", ":History<CR>", opts)
map("n", "<C-D>", ":Siblings<CR>", opts)
-- map("n", "<C-B>", ":Buffers<CR>", opts)

map(
  "n",
  "<C-P>",
  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({}))<cr>",
  noremap
)
map(
  "n",
  "<C-M>",
  "<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy({}))<cr>",
  noremap
)
map("n", "<C-T>", "<cmd>lua require('telescope.builtin').tags(require('telescope.themes').get_ivy({}))<cr>", noremap)
map(
  "n",
  "<Leader>a",
  "<cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy({}))<cr>",
  noremap
)
map("n", "<C-B>", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({}))<cr>", noremap)
map(
  "n",
  "<leader>fh",
  "<cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_ivy({}))<cr>",
  noremap
)
