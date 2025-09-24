return {
  {
    "wuz/lackluster.nvim",
    lazy = false,
    priority = 1000,
    opts = function(opts)
      local lackluster = require("lackluster")
      local color = lackluster.color -- blue, green, red, orange, black, lack, luster, gray1-9
      return {
        tweak_syntax = {
          comment = color.gray6,
        },
      }
    end,
  },
}
