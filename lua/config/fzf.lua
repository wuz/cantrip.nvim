local map = require'utils'.map
local termcode = require'utils'.termcode
local command = require'utils'.command
local cmd = vim.cmd

local opts = {noremap = true, silent = true}

map('n', '<C-P>', ':Files<CR>', opts)
map('n', '<C-T>', ':Tags<CR>', opts)
map('n', '<C-M>', ':History<CR>', opts)
map('n', '<C-D>', ':Siblings<CR>', opts)
map('n', '<C-B>', ':Buffers<CR>', opts)

vim.g.fzf_layout = { window = { width = 0.7, height = 0.6 } }
vim.g.fzf_tags_command = 'ctags --extra=+f -R'

vim.g.lens = {
  disabled_filetypes = { 'nerdtree', 'fzf', 'defx' }
}

command('Files', "fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--color', 'hl:9,hl+:14']}), <bang>0)")
command('Siblings', "fzf#vim#files(<q-args>, fzf#vim#with_preview({'dir': expand('%:p:h'), 'options': ['--color', 'hl:9,hl+:14']}), <bang>0)")


cmd("let $FZF_DEFAULT_COMMAND='fd --type f -H -E .git'")
cmd('let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"')
-- cmd("let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all --ansi --reverse --multi --color=dark --color=bg+:#4f5987,bg:#1d1f30,spinner:#39ffba,hl:#858db7 --color=fg:#eff0f6,header:#eff0f6,info:#858db7,pointer:#ff476e --color=marker:#ff476e,fg+:#a5abca,prompt:#ff476e,hl+:#39ffba --color=gutter:#2a2d46'")

