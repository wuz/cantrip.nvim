" ------------------------------------------------------------ FUNCTIONALITY

set hidden                            " remember buffer history
set history=1000                      " increase history from 20 to 1000

set undofile                                  " persistent undo
set backupdir=~/.config/nvim/backups          " use global backup directory
set directory=~/.config/nvim/swaps            " use global swaps directory
set undodir=~/.config/nvim/undo               " use global undo directory

" yank to system clipboard
vmap <Leader>y "+y 
" delete to system clipboard
vmap <Leader>d "+d 
" paste from system clipboard
nmap <Leader>p "+p 
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" replace globally
vmap <Leader>r "hy:%s/<C-r>h//gc<left><left><left>

" make line numbers relative
set relativenumber

" show line numbers
set nu

" fix backspace behavior
set backspace=indent,eol,start

" Always show status line
set laststatus=2

" enable extended regexes.
set magic

" disable annoying error bells
set noerrorbells

" disable use visual bells
set visualbell

" Set omni-completion method.
set ofu=syntaxcomplete#Complete

" more keys/sec == 1337 H4X0R
set ttyfast

set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Show the current mode.
set showmode

" Always show tab bar.
set showtabline=2

" Don't redraw all the time
set lazyredraw

" highlight matching [{}]
set showmatch

" Move more naturally up/down when wrapping is enabled.
nnoremap j gj
nnoremap k gk

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set notimeout
set ttimeout
set ttimeoutlen=10
