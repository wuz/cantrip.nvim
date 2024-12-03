return {
  {
    -- Plugin manager
    "folke/lazy.nvim",
    version = "*",
  },
  {
    -- Load cantrip as a plugin
    "wuz/cantrip.nvim",
    lazy = false,     -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    config = true,
  },
  {
    -- Lua utils
    "nvim-lua/plenary.nvim",
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
  },
  {
    -- Add extra filetypes
    "nathom/filetype.nvim",
    opts = function()
      return {
        overrides = {
          function_extensions = {
            ["json"] = function()
              vim.bo.filetype = "jsonc"
            end,
            ["mdx"] = function()
              vim.bo.filetype = "mdx"
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      require("filetype").setup(opts)
    end,
  },
  {
    -- Smoother scrolling
    "karb94/neoscroll.nvim",
    config = true,
  },
  {
    "nvimtools/hydra.nvim",
  },
  {
    -- Log timing of editor startup
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
  },
}
