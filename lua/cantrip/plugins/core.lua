return {
  {
    dir = "../cantrip",
    name = "cantrip",
    dependencies = {
      {
        dir = "~/github/wuz/eldritch",
        dependencies = {
          { "rktjmp/lush.nvim" },
        },
        enabled = false,
      },
      -- Make sure to load any colorschemes you want to use here!
      {
        "folke/tokyonight.nvim",
      },
      {
        "Yazeed1s/oh-lucy.nvim",
        enabled = false,
      },
    },
    lazy = false, -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    opts = {
      translucent = true,
      -- theme = "oh-lucy-evening",
      theme = "tokyonight",
      notes = {
        workspaces = {
          notes = "~/grimoire",
        },
      },
    },
    config = function(_, opts)
      require("cantrip").setup(opts)
      vim.g.tokyonight_dark_sidebar = true
      vim.g.tokyonight_dark_float = true
    end,
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
      background_colour = "ColorColumn",
      -- Icons for the different levels
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    },
    config = function(_, opts)
      require("notify").setup(opts)
    end,
  },
}
