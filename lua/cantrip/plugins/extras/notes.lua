return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = function()
      local config = require("cantrip").getConfig()
      return {
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {},
          ["core.norg.dirman"] = {
            config = config.notes,
          },
        },
      }
    end,
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}
