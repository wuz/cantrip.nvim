local lush = require("lush")

local base = require("neon_magic.groups.base")
local palette = require("neon_magic.palette")

---@diagnostic disable: undefined-global
return lush(function()
  return {
    NeoTreeDimText { fg = palette.shade8 },
    NeoTreeFileName { fg = palette.shade8 },
    NeoTreeGitModified { fg = palette.shade6 },
    NeoTreeGitStaged { fg = palette.shade6 },
    NeoTreeGitUntracked { fg = palette.shade6 },
    NeoTreeNormal { base.Normal },
    NeoTreeNormalNC { fg = palette.shade8, bg = palette.shade0 },
    NeoTreeTabActive { fg = palette.shade6, bg = palette.shade0 },
    NeoTreeTabInactive { fg = palette.shade0, bg = palette.shade1 },
    NeoTreeTabSeparatorActive { fg = palette.shade6, bg = palette.shade0 },
    NeoTreeTabSeparatorInactive { fg = palette.shade2, bg = palette.shade0 },
  }
end)

-- vi:nowrap
