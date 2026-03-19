return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = function()
      local config = require("cantrip").get_config()
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
