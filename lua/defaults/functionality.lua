local o = vim.o
local opt = vim.opt
local expand = vim.fn.expand

-- remember buffer history
o.hidden = true

-- increase history from 20 to 1000
o.history = 1000

-- Undo/Backups
o.undofile = true -- persistent undo
o.undodir = expand("$HOME/.config/nvim/undo") -- use global undo directory

o.ttyfast = true

--make line numbers relative
o.relativenumber = false

-- show line numbers
o.nu = false

-- fix backspace behavior
o.backspace = "indent,eol,start"

-- Always show status line
o.laststatus = 2

-- enable extended regexes.
o.magic = true

-- disable annoying error bells
o.errorbells = false

-- disable use visual bells
o.visualbell = false

-- Set omni-completion method.
o.ofu = "syntaxcomplete#Complete"

o.cmdheight = 2
opt.shortmess:append({ c = true })

o.signcolumn = "yes"

-- Show the current mode.
o.showmode = true

-- Always show tab bar.
o.showtabline = 2

-- Don't redraw all the time
o.lazyredraw = true

-- highlight matching [{}]
o.showmatch = true

-- autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

o.timeout = false
o.ttimeout = true
o.ttimeoutlen = 10
