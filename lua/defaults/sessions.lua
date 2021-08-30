local map = require'utils'.map
local fn = vim.fn
local expand = fn.expand

local sessiondir = expand('$HOME/.config/nvim/sessions')

function MakeSession()
  
end

function LoadSession()
end

-- [[

function! s:MakeSession(...)
  let b:sessiondir = $HOME . "/.config/nvim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! s:LoadSession(...)
  let b:sessiondir = $HOME . "/.config/nvim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

nnoremap <silent> <Plug>(load-session) :call <SID>LoadSession()<CR>
nnoremap <silent> <Plug>(make-session) :call <SID>MakeSession()<CR>
]]
