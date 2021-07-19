" hadar - A very purple-gray Vim theme
if exists('g:hadar_loaded')
  finish
endif

function! s:signify_unloaded(scheme) abort
  if a:scheme !=# 'hadar' && exists('g:hadar_loaded')
    unlet g:hadar_loaded
  endif
endfunction

augroup hadar_aucmds
  au!
  au ColorScheme * call s:signify_unloaded(expand('<amatch>'))
augroup END

highlight clear

if exists('syntax_on')
    syntax reset
endif

let g:colors_name = 'hadar'
let s:palette = {}
let s:palette.blackest = '#07050c'
let s:palette.black = '#322a42'
let s:palette.gray01 = '#5e596a'
let s:palette.gray02 = '#716c7b'
let s:palette.gray03 = '#807c89'
let s:palette.gray04 = '#8d8a95'
let s:palette.gray05 = '#9997a0'
let s:palette.gray06 = '#a4a1aa'
let s:palette.gray07 = '#adacb3'
let s:palette.gray08 = '#b7b5bb'
let s:palette.gray09 = '#bfbec4'
let s:palette.gray10 = '#c8c7cb'
let s:palette.gray11 = '#d0ced2'
let s:palette.gray12 = '#d6d5d9'
let s:palette.gray13 = '#dedddf'
let s:palette.gray14 = '#e4e4e6'
let s:palette.gray15 = '#ebebec'
let s:palette.white = '#e4ebfd'
let s:palette.comments = copy(s:palette.gray10)
let s:palette.purple = '#b496cf'
let s:palette.brown = '#febb53'
let s:palette.blue = '#6d6b8d'
let s:palette.lightblue = '#a0a1bb'
let s:palette.green = '#7caf7e'
let s:palette.red = '#f87c88'
let s:palette.magenta = '#b496cf'

let g:terminal_color_0 = s:palette.gray01
let g:terminal_color_1 = s:palette.red
let g:terminal_color_2 = s:palette.green
let g:terminal_color_3 = s:palette.brown
let g:terminal_color_4 = s:palette.blue
let g:terminal_color_5 = s:palette.purple
let g:terminal_color_6 = s:palette.gray09
let g:terminal_color_7 = s:palette.white

let g:terminal_color_8 = s:palette.gray03
let g:terminal_color_9 = s:palette.red
let g:terminal_color_10 = s:palette.green
let g:terminal_color_11 = s:palette.brown
let g:terminal_color_12 = s:palette.blue
let g:terminal_color_13 = s:palette.purple
let g:terminal_color_14 = s:palette.gray14
let g:terminal_color_15 = s:palette.white

hi Normal guifg=#dedddf guibg=#07050c
hi Constant guifg=#9997a0 gui=bold
hi String guifg=#c8c7cb
hi Number guifg=#a4a1aa

hi NormalFloat guifg=#dedddf guibg=#5e596a

hi Identifier guifg=#b7b5bb gui=none
hi Function guifg=#b7b5bb

hi Statement guifg=#9997a0 gui=bold
hi Operator guifg=#dedddf gui=none
hi Keyword guifg=#dedddf

hi PreProc guifg=#adacb3 gui=none

hi Type guifg=#dedddf gui=bold

hi Special guifg=#9997a0
hi SpecialComment guifg=#c8c7cb gui=bold

hi Title guifg=#adacb3 gui=bold
hi Todo guifg=#b496cf guibg=#322a42
hi Comment guifg=#c8c7cb gui=italic

hi LineNr guifg=#8d8a95 guibg=#07050c gui=none
hi FoldColumn guifg=#adacb3 guibg=#07050c gui=none
hi CursorLine guibg=#322a42 gui=none
hi CursorLineNr guifg=#e4e4e6 guibg=#322a42 gui=none

hi Visual guifg=#322a42 guibg=#a4a1aa
hi Search guifg=#5e596a guibg=#d0ced2 gui=none
hi IncSearch guifg=#322a42 guibg=#adacb3 gui=bold

hi SpellBad guifg=#f87c88 gui=undercurl
hi SpellCap guifg=#f87c88 gui=undercurl
hi SpellLocal guifg=#f87c88 gui=undercurl
hi SpellRare guifg=#febb53 gui=undercurl

hi Error guifg=#f87c88 gui=bold
hi ErrorMsg guifg=#f87c88 
hi WarningMsg guifg=#febb53 
hi ModeMsg guifg=#c8c7cb
hi MoreMsg guifg=#c8c7cb

hi MatchParen guifg=#b496cf

hi Cursor guibg=#d6d5d9
hi Underlined guifg=#b7b5bb gui=underline
hi SpecialKey guifg=#8d8a95
hi NonText guifg=#8d8a95
hi Directory guifg=#b7b5bb

hi Pmenu guifg=#c8c7cb guibg=#807c89 gui=none
hi PmenuSbar guifg=#322a42 guibg=#ebebec gui=none
hi PmenuSel guifg=#807c89 guibg=#c8c7cb
hi PmenuThumb guifg=#807c89 guibg=#bfbec4 gui=none

hi StatusLine guifg=#d0ced2 guibg=#807c89 gui=none
hi StatusLineNC guifg=#8d8a95 guibg=#5e596a gui=none
hi WildMenu guifg=#b7b5bb
hi VertSplit guifg=#807c89 guibg=#807c89 gui=none

hi DiffAdd guifg=#07050c guibg=#7caf7e
hi DiffChange guifg=#07050c guibg=#6d6b8d
hi DiffDelete guifg=#07050c guibg=#f87c88
hi DiffText guifg=#322a42 guibg=#a0a1bb
hi DiffAdded guifg=#7caf7e
hi DiffChanged guifg=#6d6b8d
hi DiffRemoved guifg=#f87c88

hi! link Character Constant
hi! link Float Number
hi! link Boolean Number

hi! link SignColumn FoldColumn
hi! link ColorColumn FoldColumn
hi! link CursorColumn CursorLine

hi! link Folded LineNr
hi! link Conceal Normal
hi! link ErrorMsg Error

hi! link Conditional Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link Exception Statement

hi! link Include PreProc
hi! link Define PreProc
hi! link Macro PreProc
hi! link PreCondit PreProc

hi! link StorageClass Type
hi! link Structure Type
hi! link Typedef Type

hi! link SpecialChar Special
hi! link Tag Special
hi! link Delimiter Special
hi! link Debug Special
hi! link Question Special

hi! link VisualNOS Visual
hi! link TabLine StatusLineNC
hi! link TabLineFill StatusLineNC
hi! link TabLineSel StatusLine

hi ALEError guifg=#ff727b ctermfg=NONE guibg=NONE ctermbg=NONE gui=undercurl cterm=undercurl guisp=#9d0006
hi ALEWarning guifg=#fabd2f ctermfg=NONE guibg=NONE ctermbg=NONE gui=undercurl cterm=undercurl guisp=#b57614
hi ALEInfo guifg=#83a598 ctermfg=NONE guibg=NONE ctermbg=NONE gui=undercurl cterm=undercurl

hi RedSign guifg=#cc241d ctermfg=124 guibg=#322a42 gui=NONE cterm=NONE
hi YellowSign guifg=#fabd2f ctermfg=214 guibg=#322a42 gui=NONE cterm=NONE
hi GreenSign guifg=#b8cc26 ctermfg=142 guibg=#322a42 gui=NONE cterm=NONE
hi BlueSign guifg=#83a5cb ctermfg=109 guibg=#322a42 gui=NONE cterm=NONE
hi AquaSign guifg=#8ec07c ctermfg=108 guibg=#322a42 gui=NONE cterm=NONE

hi RedHover guifg=#cc241d ctermfg=124 gui=NONE cterm=NONE
hi YellowHover guifg=#fabd2f ctermfg=214 gui=NONE cterm=NONE
hi OrangeHover guifg=#fd7d2f ctermfg=214 gui=NONE cterm=NONE
hi GreenHover guifg=#b8cc26 ctermfg=142 gui=NONE cterm=NONE
hi BlueHover guifg=#83a5cb ctermfg=109 gui=NONE cterm=NONE
hi AquaHover guifg=#8ec07c ctermfg=108 gui=NONE cterm=NONE
hi WhiteHover guifg=#ffffff ctermfg=108 gui=NONE cterm=NONE

hi Todo guifg=#eeeeee ctermfg=255 guibg=NONE ctermbg=NONE gui=bold cterm=bold

hi ShadyFg3 guifg=#bdae93 ctermfg=248 guibg=NONE ctermbg=NONE
hi ShadyFg1 guifg=#ebdbb2 ctermfg=223 guibg=NONE ctermbg=NONE
hi ShadyBg2 guifg=#504945 ctermfg=239 guibg=NONE ctermbg=NONE
hi ShadyBlue guifg=#83a598 ctermfg=109 guibg=NONE ctermbg=NONE
hi ShadyBrightBlue guifg=#a5c7ff ctermfg=109 guibg=NONE ctermbg=NONE
hi ShadyAqua guibg=#8ec07c ctermbg=108
hi ShadyGray guifg=#928374 ctermfg=245 guibg=NONE ctermbg=NONE
hi ShadyYellow guifg=#fabd2f ctermfg=214 guibg=NONE ctermbg=NONE
hi ShadyOrange guifg=#fe8019 ctermfg=208 guibg=NONE ctermbg=NONE

hi! link ALEErrorSign RedSign
hi! link ALEWarningSign YellowSign
hi! link ALEStyleErrorSign RedSign
hi! link ALEStyleWarningSign YellowSign
hi! link ALEInfoSign BlueSign

hi! link SignifySignAdd GreenSign
hi! link SignifySignChange AquaSign
hi! link SignifySignDelete RedSign

hi! link StartifyBracket ShadyFg3
hi! link StartifyFile ShadyFg1
hi! link StartifyNumber ShadyBlue
hi! link StartifyPath ShadyGray
hi! link StartifySlash ShadyGray
hi! link StartifySection ShadyYellow
hi! link StartifySpecial ShadyBg2
hi! link StartifyHeader ShadyOrange
hi! link StartifyFooter ShadyBg2

hi! link Sneak ShadyAqua
hi SneakLabel guifg=#fe8019 ctermfg=208 guibg=#504945 ctermbg=239
hi! link SneakScope ShadyAqua

hi! link MatchParen ShadyOrange

hi! link DiffAdded GreenSign
hi! link DiffChanged BlueSign
hi! link DiffRemoved RedSign

hi! link SpellBad RedSign
hi! link Error RedSign
hi! link ErrorMsg RedSign

let g:hadar_loaded = v:true

