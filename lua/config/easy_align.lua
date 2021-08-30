local map = require'utils'.map

-- Keybindings
local options = {silent = true, noremap = false}
map({'x', 'n'}, 'ga', '<Plug>(EasyAlign)', options)
