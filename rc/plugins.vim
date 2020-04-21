let s:dein_dir = finddir('dein.vim', '.;') 
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    let s:dein_dir = expand('$CACHE/dein').'/repos/github.com/Shougo/dein.vim/'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif

let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1
let g:dein#install_log_filename = '~/dein.log'

let s:path = expand('$CACHE/dein')
if dein#load_state(s:path)
  let s:settings_base = '~/.config/nvim/settings/plugins/'

  let s:default_toml = s:settings_base . 'default.toml'
  let s:lazy_toml = s:settings_base . 'lazy.toml'
  let s:ft_toml = s:settings_base . 'filetype.toml'

  call dein#begin(s:path, [
        \ expand('<sfile>'), s:default_toml, s:lazy_toml, s:ft_toml
        \ ])

  call dein#load_toml(s:default_toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#load_toml(s:ft_toml)

  call dein#end()
  call dein#save_state()
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endif


if !has('vim_starting') && dein#check_install()
  call dein#install()
endif

" 	call dein#add('severin-lemaignan/vim-minimap', { 'if': g:minimap })

" 	" display
" 	call dein#add('nathanaelkane/vim-indent-guides')
" 	call dein#add('airblade/vim-gitgutter')

" 	" call dein#add('ryanoasis/vim-devicons')

" 	" behavior
" 	call dein#add('Shougo/neoinclude.vim')
" 	call dein#add('wuz/ProjectLevel')
" 	call dein#add('tpope/vim-sleuth')
" 	call dein#add('Shougo/neoyank.vim')

