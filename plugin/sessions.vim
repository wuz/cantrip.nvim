function! s:MakeSession(...)
  if a:session_name
    let b:sessiondir = $HOME . "/.config/nvim/sessions" . a:0
  else
    let b:sessiondir = $HOME . "/.config/nvim/sessions" . getcwd()
  endif
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! s:LoadSession(...)
  if a:session_name
    let b:sessiondir = $HOME . "/.config/nvim/sessions" . a:0
  else
    let b:sessiondir = $HOME . "/.config/nvim/sessions" . getcwd()
  endif
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

nnoremap <silent> <Plug>(load-session) :call <SID>LoadSession()<CR>
nnoremap <silent> <Plug>(make-session) :call <SID>MakeSession()<CR>

