local lush = require("lush")

local base = require("neon_magic.groups.base")
local neotree = require("neon_magic.groups.neotree")
local typescript = require("neon_magic.groups.typescript")

--   Relative adjustment (rotate(), saturate(), desaturate(), lighten(), darken())
--   Absolute adjustment (prefix above with abs_)
--   Combination         (mix())
--   Overrides           (hue(), saturation(), lightness())
--   Access              (.h, .s, .l)
--   Coercion            (tostring(), "Concatenation: " .. color)
--   Helpers             (readable())

local M = {}

M.setup = function()
  return lush.merge { base, neotree, typescript }
end

return M
