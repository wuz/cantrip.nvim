" ------------------------------------------------------------ STATUSLINE

set noshowmode

function! VimMode()
  let current_mode = mode()
  return current_mode == 'n' ? 'Normal' : 'Insert'
endfunction

function! LinterStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?l:branchname:'⚬ '
endfunction

function! StatusSpace()
  return ' '
endfunction

function! StatusSeperator()
  return ''
endfunction

" left
set statusline=
set statusline+=%#User9#
set statusline+=%{StatusSpace()}
set statusline+=%{VimMode()}
set statusline+=%{StatusSpace()}
set statusline+=%#PmenuSel#
set statusline+=%{StatusSpace()}
set statusline+=%{StatuslineGit()}
set statusline+=%{StatusSpace()}
set statusline+=%#Constant#
set statusline+=%{StatusSpace()}
set statusline+=%f
set statusline+=%{StatusSpace()}
set statusline+=%#Constant#
set statusline+=%{dein#get_progress()}

" right
set statusline+=%=        " Switch to the right side
set statusline+=%#Constant#
set statusline+=%{LinterStatus()}
set statusline+=\ %y
set statusline+=%{StatusSeperator()}
