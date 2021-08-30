local o = vim.o
local c = vim.cmd

-- Appearance
c("set termguicolors")
o.background = "dark"
o.syntax = "on"
o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
o.fillchars = "vert:┃"

c([[highlight Comment cterm=italic gui=italic]])
c([[highlight VertSplit ctermbg=NONE]])
