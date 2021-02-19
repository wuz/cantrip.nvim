local map = require'utils'.map

-- Scuttle <C-h> (buffers) previous buffer
map('n', '<C-h>', ':bprev<CR>', noremap)
-- Scuttle <C-l> (buffers) next buffer
map('n', '<C-l>', ':bnext<CR>', noremap)
