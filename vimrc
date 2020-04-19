" This file is needed so Vim sets $MYVIMRC correctly
" ------------------------------------------------------------ SETUP

" leader is <space>
let mapleader="\<Space>"
" local leader is \
let maplocalleader = "\\"

if &compatible
  set nocompatible
endif

if has('vim_starting') && empty(argv())
  syntax off
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

let $CACHE = expand('~/.cache')

" Set augroup.
augroup MyAutoCmd
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
        \ call rc#on_filetype()
  autocmd CursorHold *.toml syntax sync minlines=300
  autocmd VimEnter * call dein#call_hook('source')
  autocmd VimEnter * call dein#call_hook('post_source')
augroup END
augroup filetypedetect
augroup END

call rc#source_rc("plugins.vim")
call rc#source_rc("settings.vim")

if has('vim_starting') && !empty(argv())
  call rc#on_filetype()
endif

