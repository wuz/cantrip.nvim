local map = require'utils'.map

map('n', '<Leader>a', '<Plug>RgRawSearch')
map('v', '<Leader>a', '<Plug>RgRawVisualSelection')
map('n', '<Leader>*', '<Plug>RgRawWordUnderCursor')

vim.g.agriculture = {
  rg_options= '--column --line-number --no-heading --color=always --smart-case'
}
