--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- ###
-- ### Lushify
-- ###
--
-- First, we'll "lushify" this file, which will enable realtime feedback for
-- your changes. We do this by running the command:
--
-- `:Lushify`
--
--  Also make sure to enable termguicolors with `:set termguicolors`.
--
-- (If it worked, your colorscheme should have changed pretty dramatically!)

local lush = require("lush")

local hsluv = lush.hsluv -- or for hsluv

local palette = {
  bg1 = hsluv(300, 0, 0),
  bg2 = hsluv(300, 0, 10),

  fg1 = hsluv(300, 0, 90),
  fg2 = hsluv(300, 0, 60),

  color1 = hsluv(360, 50, 60),
  color2 = hsluv(200, 50, 60),
  color3 = hsluv(48, 65, 82),

  errorFg = hsluv(360, 50, 80),
  errorBg = hsluv(360, 50, 50),
}

--   Relative adjustment (rotate(), saturate(), desaturate(), lighten(), darken())
--   Absolute adjustment (prefix above with abs_)
--   Combination         (mix())
--   Overrides           (hue(), saturation(), lightness())
--   Access              (.h, .s, .l)
--   Coercion            (tostring(), "Concatination: " .. color)
--   Helpers             (readable())

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    Normal { bg = palette.bg1, fg = palette.fg1 },
    CursorColumn { bg = palette.bg2 },
    CursorLine { CursorColumn },
    Cursor {},
    Directory { bold = true },
    Visual { fg = palette.bg2, bg = palette.fg2 },
    Conceal { bg = palette.bg1, fg = palette.bg1 },

    Comment { fg = Normal.bg.de(25).li(40), italic = true }, -- any comments

    Constant { fg = palette.color1 },
    Function { fg = palette.color2 },
    String { fg = palette.color2, italic = true },
    Boolean { fg = palette.color2 },
    Number { fg = palette.color2 },
    Label { fg = palette.color2, bold = true },

    Float { Number },

    Repeat { fg = palette.fg2 },
    Operator { Repeat },

    PreProc { fg = palette.color1 },
    Include { fg = palette.color1 },
    Define { fg = palette.color1 },

    StorageClass { fg = palette.color1 },
    Typedef { fg = palette.color1 },
    Type { fg = palette.color1 },
    Structure { Type },

    Identifier { fg = palette.color3 },
    Keyword { fg = palette.color2 },

    Exception { Label },

    Conditional { fg = palette.color2 },
    Character { fg = palette.color2, gui = "italic" }, --   A character constant: 'c', '\n'

    Macro { PreProc },
    PreCondit { PreProc },
    Special { Constant }, -- (*) Any special symbol
    SpecialChar { Constant }, --   Special character in a constant
    Tag { Constant }, --   You can use CTRL-] on this
    Delimiter { fg = palette.fg8 }, --   Character that needs attention
    SpecialComment { String }, --   Special things inside a comment (e.g. '\n')
    Debug { String }, --   Debugging statements

    Underlined { underline = true }, -- Text that stands out, HTML links

    Error { bg = palette.errorBg, fg = palette.errorFg }, -- Any erroneous construct

    -- NEOTREE
    NeoTreeFileIcon { Comment },
    NeoTreeFileName { fg = palette.fg1 },

    -- LineNr { Comment, gui = "italic" },
    -- LineNrBelow { LineNr },
    -- LineNrAbove { LineNr },
    -- CursorLineNr { LineNr, fg = CursorLine.bg.mix(Normal.fg, 50) },
    -- Search       { search_base },
    -- IncSearch    { bg = search_base.bg.ro(-20), fg = search_base.fg.da(90) },

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    -- sym"@text.literal"      { }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    -- sym"@text.title"        { }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    -- sym"@text.todo"         { }, -- Todo
    -- sym"@comment"           { }, -- Comment
    -- sym"@punctuation"       { }, -- Delimiter
    sym("@constant") { Constant }, -- Constant
    sym("@constant.builtin") { Special }, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    sym("@string") { String }, -- String
    sym("@string.escape") { SpecialChar }, -- SpecialChar
    sym("@string.special") { SpecialChar }, -- SpecialChar
    sym("@character") { Character }, -- Character
    sym("@character.special") { SpecialChar }, -- SpecialChar
    sym("@number") { Number }, -- Number
    sym("@boolean") { Boolean }, -- Boolean
    sym("@float") { Float }, -- Float
    sym("@function") { Function }, -- Function
    sym("@function.builtin") { Special }, -- Special
    sym("@function.macro") { Macro }, -- Macro
    sym("@parameter") { fg = palette.fg1 }, -- Identifier
    sym("@method") { Function }, -- Function
    sym("@field") { fg = palette.fg1 }, -- Identifier
    sym("@property") { fg = palette.fg1 }, -- Identifier
    sym("@constructor") { Special }, -- Special
    sym("@conditional") { Conditional }, -- Conditional
    sym("@repeat") { Repeat }, -- Repeat
    sym("@label") { Label }, -- Label
    sym("@operator") { Operator }, -- Operator
    sym("@keyword") { Keyword }, -- Keyword
    sym("@exception") { Exception }, -- Exception
    sym("@variable") { Identifier }, -- Identifier
    sym("@type") { Type }, -- Type
    sym("@type.definition") { Typedef }, -- Typedef
    sym("@storageclass") { StorageClass }, -- StorageClass
    sym("@structure") { Structure }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    sym("@include") { Include }, -- Include
    sym("@preproc") { PreProc }, -- PreProc
    sym("@debug") { Debug }, -- Debug
    -- sym"@tag"               { }, -- Tag

    sym("@type.builtin.tsx") { Type },
    sym("@tag.tsx") { fg = palette.fg1 },

    sym("@type.builtin.typescript") { Type },
    sym("@keyword.repeat.typescript") { Repeat },
    sym("@keyword.conditional.typescript") { Conditional },
    sym("@keyword.import.typescript") { Define },
    sym("@keyword.export.typescript") { Define },
    sym("@operator.typescript") { Operator },

    sym("@type.builtin.cpp") { Type },
    sym("@keyword.repeat.cpp") { Repeat },
    sym("@keyword.conditional.cpp") { Conditional },
    sym("@keyword.import.cpp") { Include },
    sym("@keyword.directive.define.cpp") { Define },
    sym("@operator.cpp") { Operator },

    -- sym"@neorg.definitions.prefix.norg"   { fg = palette.fg9, bold = true },
    -- sym"@neorg.todo_items.done.norg"      { fg = palette.gr0, bold = true },
    -- sym"@neorg.todo_items.undone.norg"    { fg = palette.er0, bold = true },
    -- sym"@neorg.todo_items.pending.norg"   { fg = palette.sa0, bold = true },
    -- sym"@neorg.todo_items.on_hold.norg"   { fg = palette.gp0, bold = true },
    -- sym"@neorg.todo_items.uncertain.norg" { fg = palette.yl0, bold = true },
    -- sym"@neorg.todo_items.cancelled.norg" { fg = palette.pi1, bold = true },
    -- sym"@neorg.todo_items.urgent.norg"    { fg = palette.sr0, bold = true },
    -- sym"@neorg.todo_items.recurring.norg" { fg = palette.gb0, bold = true },
  }
end)

return theme

-- vi:nowrap
