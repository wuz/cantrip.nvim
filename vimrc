" This file is needed so Vim sets $MYVIMRC correctly
" ------------------------------------------------------------ SETUP
if &compatible
  set nocompatible
endif 
if has('vim_starting') && empty(argv())
  syntax off
endif

" leader is <space>
let mapleader="\<Space>"
" local leader is \
let maplocalleader = "\\"

function! s:reload_settings() abort
  echom "Reloading dein settings"
  call dein#call_hook('add')
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endfunction

augroup MyAutoCmd
  autocmd!
  " autocmd BufWritePost */settings/plugins/*.toml call dein#update()
  autocmd BufWritePost vimrc,*.vim,*/plugin/*.vim,*/rc/*.vim
        \ source $MYVIMRC
  autocmd BufWritePost */settings/**/*.toml
       \ call s:reload_settings()
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
        \ call rc#on_filetype()
  autocmd CursorHold *.toml syntax sync minlines=300
augroup END
augroup filetypedetect
augroup END

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

if exists('&inccommand')
  set inccommand=nosplit
endif

let $CACHE = expand('~/.cache')

" Set augroup.

call rc#source_rc("plugins.vim")
call rc#source_rc("settings.vim")

if has('vim_starting') && !empty(argv())
  call rc#on_filetype()
endif

" let s:backups_dir = fnamemodify('$MYVIMRC',':p:h').'/backups/'
" if !isdirectory(s:backups_dir)
"   silent execute '! mkdir' s:backups_dir
" endif
