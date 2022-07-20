local map = require("cartographer")
local g = vim.g

vim.o.termguicolors = true

local list = {
  { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
  { key = "<C-e>", action = "edit_in_place" },
  { key = { "O" }, action = "edit_no_picker" },
  { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
  { key = "<C-v>", action = "vsplit" },
  { key = "<C-x>", action = "split" },
  { key = "<C-t>", action = "tabnew" },
  { key = "<", action = "prev_sibling" },
  { key = ">", action = "next_sibling" },
  { key = "P", action = "parent_node" },
  { key = "<BS>", action = "close_node" },
  { key = "<Tab>", action = "preview" },
  { key = "K", action = "first_sibling" },
  { key = "J", action = "last_sibling" },
  { key = "I", action = "toggle_git_ignored" },
  { key = "H", action = "toggle_dotfiles" },
  { key = "R", action = "refresh" },
  { key = "n", action = "create" },
  { key = "d", action = "remove" },
  { key = "D", action = "trash" },
  { key = "r", action = "rename" },
  { key = "<C-r>", action = "full_rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
  { key = "y", action = "copy_name" },
  { key = "Y", action = "copy_path" },
  { key = "gy", action = "copy_absolute_path" },
  { key = "[c", action = "prev_git_item" },
  { key = "]c", action = "next_git_item" },
  { key = "-", action = "dir_up" },
  { key = "s", action = "system_open" },
  { key = "q", action = "close" },
  { key = "?", action = "toggle_help" },
  { key = "W", action = "collapse_all" },
  { key = "S", action = "search_node" },
  { key = "<C-k>", action = "toggle_file_info" },
  { key = ".", action = "run_file_command" },
}

require("nvim-tree").setup({
  open_on_tab = true,
  ignore_ft_on_setup = { "dashboard" },
  hijack_cursor = true,
  view = {
    hide_root_folder = true,
    mappings = {
      list = list,
    },
  },
})

g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_root_folder_modifier = table.concat({ ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" })

g.nvim_tree_show_icons = {
  folders = 1,
  -- folder_arrows= 1
  files = 1,
  git = 1,
}

g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    deleted = "",
    ignored = "◌",
    renamed = "➜",
    staged = "✓",
    unmerged = "",
    unstaged = "✗",
    untracked = "",
  },
  folder = {
    -- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
    -- arrow_open = "",
    -- arrow_closed = "",
    default = "",
    empty = "", -- 
    empty_open = "",
    open = "",
    symlink = "",
    symlink_open = "",
  },
}

map.n.nore["<Leader>/"] = ":NvimTreeFindFileToggle <CR>"
