local autocmd = require "utils".autocmd
local termcode = require "utils".termcode
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local c = vim.cmd
local fn = vim.fn
local expand = fn.expand

c('let mapleader="\\<Space>"')
c('let maplocalleader="\\\\"')

-- Requires
require("plugins")

-- Global
o.inccommand = "nosplit"
o.cursorline = true
o.lazyredraw = true
o.updatetime = 100
wo.cursorcolumn = false
wo.cursorline = false
o.synmaxcol = 300

-- Completion
o.completeopt = "menuone,noselect"

-- Appearance
o.termguicolors = true
c("colorscheme warlock")
o.background = "dark"
o.syntax = "on"
o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
o.fillchars = "vert:┃"

-- Folding
o.foldlevel = 2
o.foldmethod = "marker"
o.foldmarker = "#--,--"

-- Search
o.incsearch = true -- search as characters are typed
o.hlsearch = true -- highlight matches
o.ignorecase = true -- ignore case of searches
o.gdefault = true -- default to global search
o.smartcase = true -- ignore ignorecase if uppercase letters
o.wrapscan = true -- search wraps around end of file

-- Indent
c("filetype indent on")
o.expandtab = true -- tabs are spaces
o.softtabstop = 2 -- number of columns in insert mode
o.tabstop = 2
o.smartindent = true -- indent files smartly
o.shiftwidth = 2

-- Undo/Backups
o.undofile = true -- persistent undo
o.undodir = expand("$HOME/.config/nvim/undo") -- use global undo directory

-- Autocmd
autocmd("Config", "BufWritePost plugins.lua PackerCompile")
autocmd("Config", "BufWritePost lua/*.lua luafile %")

require "maps"

vim.cmd([[highlight Comment cterm=italic gui=italic]])
vim.cmd([[highlight VertSplit ctermbg=NONE]])

-- WildMenu
o.wildmenu=true
o.wildignore=o.wildignore.."*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*"
o.wildmode="list:longest"
o.winminheight=0
