vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
local o = vim.o
local c = vim.cmd
local wo = vim.wo
local expand = vim.fn.expand

opt.hidden = true -- remember buffer history

opt.history = 1000 -- increase history from 20 to 1000

-- Undo/Backups
opt.undofile = true -- persistent undo
o.undodir = expand("$HOME/.local/share/nvim/undo") -- use global undo directory
opt.ttyfast = true
opt.relativenumber = false --make line numbers relative

-- show line numbers
opt.nu = true

-- fix backspace behavior
opt.backspace = "indent,eol,start"

-- Always show status line
opt.laststatus = 2

-- enable extended regexes.
opt.magic = true

-- disable annoying error bells
opt.errorbells = false

-- disable use visual bells
opt.visualbell = false

-- Set omni-completion method.
opt.ofu = "syntaxcomplete#Complete"

opt.cmdheight = 2
opt.shortmess:append({ c = true })

opt.signcolumn = "yes"

-- Show the current mode.
opt.showmode = true

-- Always show tab bar.
opt.showtabline = 2

-- Don't redraw all the time
opt.lazyredraw = true

-- highlight matching [{}]
opt.showmatch = true

-- autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

opt.timeout = false
opt.ttimeout = true
opt.ttimeoutlen = 10

-- Global
opt.mouse = "a"
opt.inccommand = "nosplit"
opt.cursorline = true
opt.lazyredraw = true
opt.updatetime = 100
wo.cursorcolumn = false
wo.cursorline = true
opt.synmaxcol = 300
opt.splitbelow = true
opt.splitright = true

-- Indent
c("filetype indent on")
opt.expandtab = true -- tabs are spaces
opt.softtabstop = 2 -- number of columns in insert mode
opt.tabstop = 2
opt.smartindent = true -- indent files smartly
opt.shiftwidth = 2

-- Search
opt.incsearch = true -- search as characters are typed
opt.hlsearch = true -- highlight matches
opt.ignorecase = true -- ignore case of searches
opt.gdefault = true -- default to global search
opt.smartcase = true -- ignore ignorecase if uppercase letters

opt.textwidth = 80
opt.wrapscan = true -- search wraps around end of file
opt.wrap = false -- Disable line wrap

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Folding
opt.foldlevel = 2
opt.foldmethod = "marker"
opt.foldmarker = "#--,--"

-- WildMenu
opt.wildmenu = true
opt.wildignore = vim.tbl_deep_extend("force", opt.wildignore, {
  "*.jpg",
  "*.jpeg",
  "*.gif",
  "*.png",
  "*.gif",
  "*.psd",
  "*.o",
  "*.obj",
  "*.min.js",
  "*/smarty/*",
  "*/vendor/*",
  "*/node_modules/*",
  "*/.git/*",
  "*/.hg/*",
  "*/.svn/*",
  "*/.sass-cache/*",
  "*/log/*",
  "*/tmp/*",
  "*/build/*",
  "*/ckeditor/*",
})
opt.wildmode = "longest:full,full"
opt.winminheight = 0
opt.winminwidth = 5

-- Appearance
c("set termguicolors")
opt.background = "dark"
opt.syntax = "on"
opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
opt.fillchars = { vert = "┃" }

c([[highlight VertSplit ctermbg=NONE]])

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end
