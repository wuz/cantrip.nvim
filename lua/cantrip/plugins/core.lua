return {
  { "folke/lazy.nvim", version = "*" },
  {
    "wuz/cantrip.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    config = true,
  },
  {
    "nathom/filetype.nvim",
  },
  { "nvim-lua/plenary.nvim" },
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 2000,
      background_colour = "FloatBorder",
      -- Icons for the different levels
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    },
  },
}
