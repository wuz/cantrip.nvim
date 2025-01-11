local lush = require("lush")

local base = require("neon_magic.groups.base")
local palette = require("neon_magic.palette")

---@diagnostic disable: undefined-global
return lush(function(injected_functions)
  local sym = injected_functions.sym

  return {
    sym("@markup.heading.1.markdown") {
      fg = palette.dark_yellow,
      bold = true,
    },
    sym("@markup.heading.2.markdown") {
      fg = palette.purple,
      gui = "italic",
    },
    sym("@markup.heading.3.markdown") {
      fg = palette.fg2,
      gui = "italic",
    },
    sym("@markup.heading.4.markdown") {
      fg = palette.fg1,
      gui = "italic",
    },
    sym("@markup.heading.5.markdown") {
      fg = palette.fg1,
      gui = "italic",
    },
    sym("@markup.heading.6.markdown") {
      fg = palette.fg1,
      gui = "italic",
    },
    sym("@markup.link.markdown_inline") { base.Comment },
    sym("@markup.link.url.markdown_inline") {
      fg = palette.blue,
      gui = "underline",
    },
    sym("@markup.link.label.markdown_inline") {
      fg = palette.fg1,
    },
  }
end)

-- vi:nowrap
