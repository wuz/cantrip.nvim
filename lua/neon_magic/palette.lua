local lush = require("lush")

local hsluv = lush.hsluv

local base_hue = 280

-- local medium_green = hsluv(151.4, 100, 75.9)
-- local dark_green = hsluv(156.4, 91.4, 63.5)
--
-- local yellow = hsluv(65.3, 96.2, 90.3)
-- local dark_yellow = hsluv(54.7, 100, 84.4)
--
-- local dark_purple = hsluv(280, 52.3, 51.1)
--
-- local blue = hsluv(192.2, 100.0, 88.6)
-- local dark_blue = hsluv(192.2, 100.0, 62.5)

local palette = {
  shade0 = hsluv(base_hue, 21.3, 5),
  shade1 = hsluv(base_hue, 21.3, 10),
  shade2 = hsluv(base_hue, 21.3, 15),
  shade3 = hsluv(base_hue, 21.3, 20),
  shade4 = hsluv(base_hue, 21.3, 25),
  shade5 = hsluv(base_hue, 21.3, 30),
  shade6 = hsluv(base_hue, 21.3, 40),
  shade7 = hsluv(base_hue, 21.3, 80),
  shade8 = hsluv(base_hue, 21.3, 94.5),

  color0 = hsluv(base_hue, 100, 55.7),
  color1 = hsluv(4.6, 100, 58.9),
  color2 = hsluv(151.4, 100, 89.9),
  color3 = hsluv(54.7, 100, 84.4),
}

return palette
