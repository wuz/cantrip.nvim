" ------------------------------------------------------------ AUTOCOMMANDS

" Reload vimrc
augroup reload_vimrc
  autocmd!
  autocmd bufwritepost .vimrc,*.vim source $MYVIMRC
augroup END

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

