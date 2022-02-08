local lush = require("lush")
local hsluv = lush.hsluv

local deep_dark = hsluv("#191b2a")
local graydient = hsluv("#eff0f6")
local warlock = hsluv("#A78FFF")

local theme = lush(function()
  return {
    Normal({ bg = deep_dark, fg = graydient }),
    CursorLine({ bg = Normal.bg.lighten(5) }),
    Visual({ bg = CursorLine.bg, fg = Normal.fg.rotate(180) }),
    CursorColumn({ CursorLine }),
    Whitespace({ fg = Normal.bg.desaturate(25).lighten(25) }),
    Comment({ Whitespace, gui = "italic" }),
    LineNr({ bg = Normal.bg.la(10), fg = Normal.bg.li(5) }), -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr({ bg = CursorLine.bg, fg = Normal.fg.ro(180) }), -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    SearchBase({ bg = warlock.da(20), fg = Normal.fg }),
    -- Search({ search_base }),
    -- IncSearch({ bg = search_base.bg.ro(-20), fg = search_base.fg.da(90) }),
  }
end)

return theme
