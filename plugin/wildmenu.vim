" ------------------------------------------------------------ WILDMENU

" use wildmenu
set wildmenu
" tab complete commands
set wildchar=<TAB>

" ignore certain extensions in wildmenu
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*

" Complete only until point of ambiguity.
set wildmode=list:longest

" splits reduced to single line.
set winminheight=0
