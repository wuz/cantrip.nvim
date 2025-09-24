return {
  {
    "vieitesss/miniharp.nvim",
    opts = {
      autoload = true,
      autosave = true,
      show_on_autoload = false,
    },
    keys = function()
      local miniharp = require("miniharp")
      return {
        {
          "<leader>mt",
          miniharp.toggle_file,
          desc = "miniharp: toggle file mark",
        },
        {
          "<leader>ms",
          miniharp.show_list,
          desc = "miniharp: show file marks",
        },
        -- Toggle previous & next buffers stored within Harpoon list
        {
          "[m",
          miniharp.prev,
          desc = "miniharp: prev file mark",
        },
        {
          "]m",
          miniharp.next,
          desc = "miniharp: next file mark",
        },
      }
    end,
  },
}
