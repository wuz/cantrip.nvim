local command = require "utils".command
local map = require "utils".map

command("Owners", "! git blame --line-porcelain % | sed -n 's/^author //p' | sort | uniq -c | sort -rn")

vim.cmd('let g:gina#command#blame#formatter#format = "%au|%su%=%ti|%ma%in"')

map("n", "<Leader>g", ":Gina status<CR>", noremap)
map("n", "<Leader>c", ":Gina commit<CR>", noremap)
