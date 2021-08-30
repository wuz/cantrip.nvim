local o = vim.o
local c = vim.cmd

-- Indent
c("filetype indent on")
o.expandtab = true -- tabs are spaces
o.softtabstop = 2 -- number of columns in insert mode
o.tabstop = 2
o.smartindent = true -- indent files smartly
o.shiftwidth = 2
