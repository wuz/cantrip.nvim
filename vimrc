" This file is needed so Vim sets $MYVIMRC correctly
" ------------------------------------------------------------ SETUP

execute 'source ' . fnamemodify(expand('<sfile>'), ':h').'/cantrip.vim'

call rc#source_rc("plugins.vim")
call rc#source_rc("settings.vim")
call rc#source_rc("theme_overrides.vim")

if &compatible
  set nocompatible
endif 
if has('vim_starting') && empty(argv())
  syntax off
endif

function! s:reload_settings() abort
  echom "Reloading dein settings"
  call dein#call_hook('add')
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endfunction

augroup Cantrip
  autocmd!
  " autocmd BufWritePost */settings/plugins/*.toml call dein#update()
  autocmd BufWritePost vimrc,*.vim,*/plugin/*.vim,*/rc/*.vim
        \ source $MYVIMRC
  autocmd BufWritePost */cantrip/**/*.toml
       \ call s:reload_settings()
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
        \ call rc#on_filetype()
  autocmd CursorHold *.toml syntax sync minlines=300
augroup END
augroup filetypedetect
augroup END

if has('vim_starting') && !empty(argv())
  call rc#on_filetype()
endif

if !isdirectory(g:cantrip#backups_dir)
  silent execute '! mkdir' g:catnrip#backups_dir
endif
