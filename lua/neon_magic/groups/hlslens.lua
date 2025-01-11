local lush = require("lush")

local base = require("neon_magic.groups.base")

---@diagnostic disable: undefined-global
return lush(function()
  return {
    HlSearchNear { base.CurSearch },
    HlSearchLens { base.WildMenu },
    HlSearchLensNear { base.CurSearch },
  }
end)

-- vi:nowrap
