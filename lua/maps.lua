local map = require "utils".map
local autocmd = require "utils".autocmd

-- Scuttle <C-h> (buffers) previous buffer
map("n", "<C-h>", ":bprev<CR>", noremap)
-- Scuttle <C-l> (buffers) next buffer
map("n", "<C-l>", ":bnext<CR>", noremap)

function CenterToggle()
  local name = "_centered_"
  if vim.fn.bufwinnr(name) > 0 then
    vim.cmd("wincmd o")
  else
    local width = (vim.o.columns) / 3 - 20
    vim.cmd("topleft " .. width .. "vsplit +setlocal\\ nobuflisted " .. name .. " | wincmd p")
    vim.cmd("botright " .. width .. "vsplit +setlocal\\ nobuflisted " .. name .. " | wincmd p")
  end
  autocmd(
    "CenterToggle",
    'bufenter * if (winnr("$") == 2 && bufname(winbufnr(0)) == "' ..
      name .. '" && bufname(winbufnr(1)) == "' .. name .. '") | qall | endif'
  )
end

map("n", "<Leader>G", ":lua CenterToggle()<CR>", noremap)

map("n", "+", ':exe "resize " . (winheight(0) * 6/5)<CR>', noremap)
map("n", "-", ':exe "resize " . (winheight(0) * 5/6)<CR>', noremap)
map("n", "<Leader><", ':exe "vertical resize " . (winwidth(0) * 6/5)<CR>', noremap)
map("n", "<Leader>>", ':exe "vertical resize " . (winwidth(0) * 5/6)<CR>', noremap)

map("n", "<Leader>|", ":vsplit<CR><C-w><C-w>", noremap)
map("n", "<Leader>-", ":split<CR><C-w><C-w>", noremap)

map("t", "<Esc>", "<C-\\><C-n>", noremap)
map("t", "<M-[>", "<Esc>", noremap)
map("t", "<C-v><Esc>", "<Esc>", noremap)

map("n", "<C-S-M-h>", "<Esc><C-w>h", noremap)

-- vim.cmd([[
--   call arpeggio#map('i', '', 0, '<C-h><S-h><M-h>', '<Esc><C-w>h')
--] ])
