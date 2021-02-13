local o = vim.o
local wo = vim.wo
local bo = vim.bo
local c = vim.cmd
local fn = vim.fn
local expand = fn.expand

c('let mapleader="\\<Space>"')
c('let maplocalleader="\\\\"')

-- Requires
require('plugins')

-- Global
o.inccommand='nosplit'
o.cursorline=true
o.lazyredraw=true
o.updatetime=100
wo.cursorcolumn=false
wo.cursorline=false
o.synmaxcol=300

-- Completion
o.completeopt = "menuone,noselect"

-- Appearance
o.termguicolors=true
c('colorscheme horizon')
o.background='dark'
o.syntax='on'
o.guicursor = 'n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor'
o.fillchars = "vert:┃"

-- Folding
o.foldlevel=2
o.foldmethod='marker'
o.foldmarker='#--,--'

-- Search
o.incsearch=true -- search as characters are typed
o.hlsearch=true -- highlight matches
o.ignorecase=true -- ignore case of searches
o.gdefault=true -- default to global search
o.smartcase=true -- ignore ignorecase if uppercase letters
o.wrapscan=true -- search wraps around end of file

-- Indent
c('filetype indent on')
o.expandtab=true -- tabs are spaces
o.softtabstop=2 -- number of columns in insert mode
o.smartindent=true -- indent files smartly
o.ts=2
o.sw=2
o.et=true

-- Undo/Backups
o.undofile=true -- persistent undo
o.backupdir=expand('~/.config/nvim/backups') -- use global backup directory
o.directory=expand('~/.config/nvim/swaps') -- use global swaps directory
o.undodir=expand('~/.config/nvim/undo') -- use global undo directory
