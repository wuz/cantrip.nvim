local autocmd = require'utils.autocmd'

autocmd('my-glyph-palette', 'FileType fern call glyph_palette#apply()')
autocmd('my-glyph-palette', 'FileType nerdtree,startify call glyph_palette#apply()')
