return {
  { "folke/lazy.nvim", version = "*" },
  {
    "wuz/cantrip.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    config = true,
  },
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  {
    "nathom/filetype.nvim",
    opts = function()
      return {
        overrides = {
          function_extensions = {
            ["json"] = function()
              vim.bo.filetype = "jsonc"
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      require("filetype").setup(opts)
    end,
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
