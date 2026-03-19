return {
  {
    "https://codeberg.org/andyg/leap.nvim.git",
    version = "*",
    dependencies = { "tpope/vim-repeat" },
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    opts = {},
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
      vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
      vim.keymap.set({ "x", "o" }, "R", function()
        require("leap.treesitter").select({
          -- To increase/decrease the selection in a clever-f-like manner,
          -- with the trigger key itself (vRRRRrr...). The default keys
          -- (<enter>/<backspace>) also work, so feel free to skip this.
          opts = require("leap.user").with_traversal_keys("R", "r"),
        })
      end)
      vim.keymap.set({ "n", "x", "o" }, "gs", function()
        require("leap.remote").action()
      end)
    end,
  },
}

