local lush = require("lush")

local palette = require("neon_magic.palette")

---@diagnostic disable: undefined-global
return lush(function()
  return {
    Normal { bg = palette.shade0, fg = palette.shade8 }, -- Normal text
    Hidden { bg = Normal.bg, fg = Normal.bg },
    Comment { bg = Normal.bg, fg = palette.shade7, gui = "italic" }, -- Any comment
    Search { Normal, fg = palette.color3, gui = "italic", bold = true }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    ColorColumn { Normal }, -- Columns set with 'colorcolumn'
    Conceal { Hidden }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    CurSearch { Search }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    Cursor { bg = palette.shade6, fg = palette.shade1 }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM { bg = palette.shade8, fg = palette.shade1 }, -- Like Cursor, but used when in IME mode |CursorIM|
    CursorColumn { bg = palette.shade1 }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine { bg = palette.shade1 }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory { bg = palette.shade1, fg = palette.shade6 }, -- Directory names (and other special names in listings)
    DiffAdd { Normal, underline = true, sp = palette.color2 }, -- Diff mode: Added line |diff.txt|
    DiffChange { Normal, underline = true, sp = palette.color0 }, -- Diff mode: Changed line |diff.txt|
    DiffDelete { Normal, underline = true, sp = palette.color1 }, -- Diff mode: Deleted line |diff.txt|
    DiffText { Normal, underline = true, sp = palette.shade8 }, -- Diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer { Normal }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    TermCursor { bg = palette.shade8, fg = palette.shade1 }, -- Cursor in a focused terminal
    TermCursorNC { Normal }, -- Cursor in an unfocused terminal
    ErrorMsg { bg = palette.shade0, fg = palette.shade6 }, -- Error messages on the command line
    VertSplit { bg = palette.shade1, fg = palette.shade1 }, -- Column separating vertically split windows
    Folded { bg = palette.shade3, fg = palette.shade5 }, -- Line used for closed folds
    FoldColumn { Comment }, -- 'foldcolumn'
    SignColumn { Comment }, -- Column where |signs| are displayed
    IncSearch { Search }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute { bg = palette.shade6, fg = palette.shade1 }, -- |:substitute| replacement text highlighting
    LineNr { Comment }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNrAbove { Comment }, -- Line number for when the 'relativenumber' option is set, above the cursor line
    LineNrBelow { Comment }, -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr { bg = palette.shade1, fg = palette.shade6 }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    CursorLineFold { Comment }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    CursorLineSign { Comment }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen { bg = palette.shade1, fg = palette.shade6 }, -- Character under the cursor or just before it, if it is a paishade6 bracket, and its match. |pi_paren.txt|
    ModeMsg { bg = palette.shade1, fg = palette.shade6 }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea { Normal }, -- Area for messages and cmdline
    MsgSeparator { Normal }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg { bg = palette.shade1, fg = palette.shade6 }, -- |more-prompt|
    NonText { bg = palette.shade1, fg = palette.shade5 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    NormalFloat { Normal },
    FloatBorder { Comment }, -- Border of floating windows.
    FloatTitle { bg = palette.shade1, fg = palette.shade6 }, -- Title of floating windows.
    NormalNC { Normal }, -- normal text in non-current windows
    Pmenu { Normal }, -- Popup menu: Normal item.
    PmenuSel { Normal }, -- Popup menu: Selected item.
    PmenuKind { Normal }, -- Popup menu: Normal item "kind"
    PmenuKindSel { Normal }, -- Popup menu: Selected item "kind"
    PmenuExtra { Normal }, -- Popup menu: Normal item "extra text"
    PmenuExtraSel { Normal }, -- Popup menu: Selected item "extra text"
    PmenuSbar { Normal }, -- Popup menu: Scrollbar.
    PmenuThumb { Normal }, -- Popup menu: Thumb of the scrollbar.
    Question { bg = palette.shade1, fg = palette.shade6 }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine { bg = palette.shade3, fg = palette.shade8 }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpecialKey { bg = palette.shade1, fg = palette.shade5 }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad { Normal, undercurl = true, sp = palette.color1 }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap { Normal, undercurl = true, sp = palette.color3 }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal { Normal, undercurl = true, sp = palette.color3 }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare { Normal, undercurl = true, sp = palette.shade3 }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine { Normal }, -- Status line of current window
    StatusLineNC { Comment }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine { bg = palette.shade1, fg = palette.shade8 }, -- Tab pages line, not active tab page label
    TabLineFill { Normal }, -- Tab pages line, where there are no labels
    TabLineSel { bg = palette.shade6, fg = palette.shade8 }, -- Tab pages line, active tab page label
    Title { bg = palette.shade1, fg = palette.shade6 }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual { bg = palette.shade3, fg = palette.shade8 }, -- Visual mode selection
    VisualNOS { Visual }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg { bg = palette.shade1, fg = palette.shade6 }, -- Warning messages
    Whitespace { bg = palette.shade1, fg = palette.shade3 }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Winseparator { bg = palette.shade1, fg = palette.shade5 },
    WildMenu { Normal }, -- Current match in 'wildmenu' completion
    WinBar { Comment }, -- Window bar of current window
    WinBarNC { Comment }, -- Window bar of not-current windows
    IblScope { Whitespace },
    Statement { fg = palette.shade6 },
    String { fg = palette.color0.desaturate(40).lighten(30) },
    Number { fg = palette.color0.desaturate(20) },
    Special { fg = palette.color0.desaturate(80) },
  }
end)

-- vi:nowrap
