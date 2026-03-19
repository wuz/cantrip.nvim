return {
  {
    "petertriho/nvim-scrollbar",
    lazy = true,
    dependencies = {
      "kevinhwang91/nvim-hlslens",
    },
    opts = function()
      return {
        excluded_filetypes = {
          "prompt",
          "snacks_dashboard",
        },
        handlers = {
          diagnostic = true,
          search = true,
        },
      }
    end,
    config = function(_, opts)
      require("scrollbar").setup(opts)
      require("scrollbar.handlers.search").setup()
    end,
  },
}
