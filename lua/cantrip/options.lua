vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
local o = vim.o
local c = vim.cmd
local wo = vim.wo

opt.hidden = true  -- remember buffer history
opt.history = 1000 -- increase history from 20 to 1000

-- Undo/Backups
opt.undofile = true                                -- persistent undo
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Directory for undo files
opt.undofile = true                                -- Enable persistent undo
opt.ttyfast = true
opt.relativenumber = true                          -- use relative numbers
opt.number = true                                  -- show line numbers
opt.numberwidth = 2
opt.scrolloff = 8                                  -- show 8 lines above/below cursor

-- fix backspace behavior
opt.backspace = "indent,eol,start"

-- Always show status line
opt.laststatus = 0

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

opt.showtabline = 2 -- Always show tab bar.

-- Don't redraw all the time
opt.lazyredraw = true

-- highlight matching [{}]
opt.showmatch = true

opt.timeout = true
opt.ttimeout = true
opt.ttimeoutlen = 10
opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key

-- Global
opt.mouse = "a"
opt.inccommand = "nosplit"
o.cursorline = true
opt.cursorlineopt = { "number" }
opt.updatetime = 100
wo.cursorcolumn = false
wo.cursorline = true
opt.synmaxcol = 300
opt.splitbelow = true
opt.splitright = true
opt.completeopt = { "menuone", "popup", "noinsert" } -- Options for completion menu
opt.winborder = "rounded"

-- Indent
vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation
opt.autoindent = true
opt.expandtab = true -- tabs are spaces
opt.softtabstop = 2 -- number of columns in insert mode
opt.tabstop = 2
opt.smartindent = true -- indent files smartly
opt.shiftwidth = 2
opt.listchars = "tab: ,multispace:|   ,eol:󰌑" -- Characters to show for tabs, spaces, and end of line
opt.list = true

-- Search
opt.incsearch = true  -- search as characters are typed
opt.hlsearch = true   -- highlight matches
opt.ignorecase = true -- ignore case of searches
opt.gdefault = true   -- default to global search
opt.smartcase = true  -- ignore ignorecase if uppercase letters

opt.swapfile = false

opt.textwidth = 80
opt.wrapscan = true -- search wraps around end of file
opt.wrap = false    -- Disable line wrap

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Folding
o.foldcolumn = "1"
o.foldenable = false
o.foldlevel = 99

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
opt.termguicolors = true
opt.background = "dark"
opt.syntax = "on"
opt.colorcolumn = "80"   -- Highlight column 80
opt.signcolumn = "yes:1" -- Always show sign column
opt.guicursor = {
	-- "n-sm:block",
	"v:hor50",
	"c-ci-cr-i-ve:ver10",
	"o-r:hor10",
	"a:Cursor/Cursor-blinkwait1-blinkon1-blinkoff1",
}
opt.fillchars = {
	eob = " ",
	diff = "╱",
	fold = " ",
	foldclose = ">",
	foldopen = "∨",
	foldsep = " ",
	msgsep = "━",
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}

opt.viewoptions = {
	"cursor",
	"folds",
}

c([[highlight VertSplit ctermbg=NONE]])

if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess:append({ C = true })
end
