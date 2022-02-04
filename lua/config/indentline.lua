vim.cmd([[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]])

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
  char = "",
  show_trailing_blankline_indent = false,
})
