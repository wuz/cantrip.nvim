return {
  {
    "echasnovski/mini.bufremove",
    version = false,
    keys = {
      {
        "<Leader>bc",
        function()
          require("mini.bufremove").delete(0)
        end,
        desc = "Close buffer",
      },
    },
    config = true,
  },
}