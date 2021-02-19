local command = require'utils'.command

command('Owners', "! git blame --line-porcelain % | sed -n 's/^author //p' | sort | uniq -c | sort -rn")

vim.cmd('let g:gina#command#blame#formatter#format = "%au|%su%=%ti|%ma%in"')
