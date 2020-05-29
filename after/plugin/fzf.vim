" ------------------------------------------------------------ FZF/SEARCH

" let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow(40, 40)' }
let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.6 } }

let g:lens#disabled_filetypes = ['nerdtree', 'fzf']

let g:fzf_tags_command = 'ctags --extra=+f -R'

let g:fzf_action = {
  \ 'ctrl-q': function('BuildQuickfixList'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_COMMAND='fd --type f'
let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all --ansi --reverse --multi
  \ --color=dark
  \ --color=bg+:#4f5987,bg:#1d1f30,spinner:#39ffba,hl:#858db7
  \ --color=fg:#eff0f6,header:#eff0f6,info:#858db7,pointer:#ff476e
  \ --color=marker:#ff476e,fg+:#a5abca,prompt:#ff476e,hl+:#39ffba
  \ --color=gutter:#2a2d46'


command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>,
                                  \ fzf#vim#with_preview({'options': ['--color', 'hl:9,hl+:14']}), <bang>0
                              \ )

command! -bang -nargs=? -complete=dir Siblings call fzf#vim#files(<q-args>,
                                  \ fzf#vim#with_preview({'dir': expand('%:p:h'), 'options': ['--color', 'hl:9,hl+:14']}), <bang>0
                              \ )

command! -bang -nargs=* Rg call fzf#vim#grep(
                                  \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, 
                                  \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0
                              \ )

command! -bang -nargs=* RgWord call fzf#vim#grep(
                                  \ 'rg --column --line-number  --no-heading --color=always --smart-case -w '.shellescape(<q-args>), 1, 
                                  \ fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0
                              \ )
