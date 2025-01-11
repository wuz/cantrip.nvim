local lush = require("lush")

local base = require("neon_magic.groups.base")
local palette = require("neon_magic.palette")

---@diagnostic disable: undefined-global
return lush(function(injected_functions)
  local sym = injected_functions.sym

  return {
    sym("@tag.attribute.tsx") {
      fg = palette.shade6,
    },
    sym("@tag.tsx") {
      fg = palette.shade6,
      bold = true,
    },
    sym("@variable.tsx") {
      fg = palette.shade6,
    },
  }
end)

-- vi:nowrap
