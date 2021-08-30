local o = vim.o

-- WildMenu
o.wildmenu = true
o.wildignore =
  o.wildignore ..
  "*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*"
o.wildmode = "list:longest"
o.winminheight = 0
