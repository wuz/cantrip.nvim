set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "warlock"

hi Cursor ctermfg=233 ctermbg=134 cterm=NONE guifg=#120f14 guibg=#b05cea gui=NONE
hi Visual ctermfg=NONE ctermbg=65 cterm=NONE guifg=NONE guibg=#4a9267 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=235 cterm=NONE guifg=NONE guibg=#27252b gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=235 cterm=NONE guifg=NONE guibg=#27252b gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=235 cterm=NONE guifg=NONE guibg=#27252b gui=NONE
hi LineNr ctermfg=102 ctermbg=235 cterm=NONE guifg=#7c7e88 guibg=#27252b gui=NONE
hi VertSplit ctermfg=59 ctermbg=59 cterm=NONE guifg=#4f4f57 guibg=#4f4f57 gui=NONE
hi MatchParen ctermfg=43 ctermbg=NONE cterm=underline guifg=#13c8c3 guibg=NONE gui=underline
hi StatusLine ctermfg=195 ctermbg=59 cterm=bold guifg=#e6edfc guibg=#4f4f57 gui=bold
hi StatusLineNC ctermfg=195 ctermbg=59 cterm=NONE guifg=#e6edfc guibg=#4f4f57 gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=65 cterm=NONE guifg=NONE guibg=#4a9267 gui=NONE
hi IncSearch ctermfg=233 ctermbg=223 cterm=NONE guifg=#120f14 guibg=#fad69f gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=223 ctermbg=NONE cterm=NONE guifg=#fad69f guibg=NONE gui=NONE
hi Folded ctermfg=215 ctermbg=233 cterm=NONE guifg=#eea633 guibg=#120f14 gui=NONE

hi Normal ctermfg=195 ctermbg=233 cterm=NONE guifg=#e6edfc guibg=#120f14 gui=NONE
hi Boolean ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi Character ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi Comment ctermfg=215 ctermbg=NONE cterm=NONE guifg=#eea633 guibg=NONE gui=NONE
hi Conditional ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi Constant ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi Define ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi DiffAdd ctermfg=195 ctermbg=64 cterm=bold guifg=#e6edfc guibg=#427e09 gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#870304 guibg=NONE gui=NONE
hi DiffChange ctermfg=195 ctermbg=17 cterm=NONE guifg=#e6edfc guibg=#192d4e gui=NONE
hi DiffText ctermfg=195 ctermbg=24 cterm=bold guifg=#e6edfc guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Float ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi Function ctermfg=177 ctermbg=NONE cterm=NONE guifg=#c68cec guibg=NONE gui=NONE
hi Identifier ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi Keyword ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi Label ctermfg=223 ctermbg=NONE cterm=NONE guifg=#fad69f guibg=NONE gui=NONE
hi NonText ctermfg=215 ctermbg=234 cterm=NONE guifg=#eea633 guibg=#1d1a20 gui=NONE
hi Number ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi Operator ctermfg=134 ctermbg=NONE cterm=NONE guifg=#b05cea guibg=NONE gui=NONE
hi PreProc ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi Special ctermfg=195 ctermbg=NONE cterm=NONE guifg=#e6edfc guibg=NONE gui=NONE
hi SpecialKey ctermfg=215 ctermbg=235 cterm=NONE guifg=#eea633 guibg=#27252b gui=NONE
hi Statement ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi StorageClass ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi String ctermfg=223 ctermbg=NONE cterm=NONE guifg=#fad69f guibg=NONE gui=NONE
hi Tag ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi Title ctermfg=195 ctermbg=NONE cterm=bold guifg=#e6edfc guibg=NONE gui=bold
hi Todo ctermfg=215 ctermbg=NONE cterm=inverse,bold guifg=#eea633 guibg=NONE gui=inverse,bold
hi Type ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi rubyFunction ctermfg=177 ctermbg=NONE cterm=NONE guifg=#c68cec guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=223 ctermbg=NONE cterm=NONE guifg=#fad69f guibg=NONE gui=NONE
hi rubyConstant ctermfg=78 ctermbg=NONE cterm=NONE guifg=#4dca86 guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=223 ctermbg=NONE cterm=NONE guifg=#fad69f guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi rubyInclude ctermfg=177 ctermbg=NONE cterm=NONE guifg=#c68cec guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi rubyRegexp ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi rubyEscape ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi rubyControl ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi rubyOperator ctermfg=134 ctermbg=NONE cterm=NONE guifg=#b05cea guibg=NONE gui=NONE
hi rubyException ctermfg=177 ctermbg=NONE cterm=NONE guifg=#c68cec guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=78 ctermbg=NONE cterm=NONE guifg=#4dca86 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=195 ctermbg=NONE cterm=NONE guifg=#e6edfc guibg=NONE gui=NONE
hi erubyComment ctermfg=215 ctermbg=NONE cterm=NONE guifg=#eea633 guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=43 ctermbg=NONE cterm=NONE guifg=#13c8c3 guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi yamlAnchor ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi yamlAlias ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=223 ctermbg=NONE cterm=NONE guifg=#fad69f guibg=NONE gui=NONE
hi cssURL ctermfg=102 ctermbg=NONE cterm=NONE guifg=#808391 guibg=NONE gui=NONE
hi cssFunctionName ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi cssColor ctermfg=105 ctermbg=NONE cterm=NONE guifg=#9898ed guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi cssClassName ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi cssValueLength ctermfg=211 ctermbg=NONE cterm=NONE guifg=#fe969e guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
