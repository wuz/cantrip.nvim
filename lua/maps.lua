local map = require'utils'.map
local autocmd = require'utils'.autocmd

-- Scuttle <C-h> (buffers) previous buffer
map('n', '<C-h>', ':bprev<CR>', noremap)
-- Scuttle <C-l> (buffers) next buffer
map('n', '<C-l>', ':bnext<CR>', noremap)

function CenterToggle()
  local name = '_centered_';
  if vim.fn.bufwinnr(name) > 0 then
    vim.cmd('wincmd o')
  else
    local width = (vim.o.columns) / 3 - 20;
    vim.cmd('topleft '..width..'vsplit +setlocal\\ nobuflisted '..name..' | wincmd p')
    vim.cmd('botright '..width..'vsplit +setlocal\\ nobuflisted '..name..' | wincmd p')
  end
  autocmd('CenterToggle', 'bufenter * if (winnr("$") == 2 && bufname(winbufnr(0)) == "'..name..'" && bufname(winbufnr(1)) == "'..name..'") | qall | endif')
end

map('n', '<Leader>G', ':lua CenterToggle()<CR>', noremap)
