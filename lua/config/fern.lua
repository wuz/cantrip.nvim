local map = require'utils'.map
local execute = vim.api.nvim_command

execute('let g:fern#renderer = "nerdfont"')

map('n', '<Leader>/', ':Fern . -reveal=% -drawer -toggle<CR>')
