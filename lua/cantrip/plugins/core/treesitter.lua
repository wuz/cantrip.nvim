return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    -- build = function()
    --   require("nvim-treesitter").update(nil, { summary = true })
    -- end,
    -- event = { "VeryLazy" },
    -- cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      -- autopairs = { enable = true },
      tree_docs = {
        enable = true,
      },
      indent = { enable = true },
      matchup = {
        enable = true,
      },
      ensure_installed = {
        "vimdoc",
        "query",
        "regex",
        "vim",
        "yaml",
        "bash",
        "c",
        "markdown",
        "lua",
        "markdown_inline",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      highlight = {
        enable = true,
        -- Disable highlights on big files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB (or whatever)
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    },
    config = function(_, opts)
      local Cantrip = require("cantrip.utils")
      require("nvim-treesitter").setup(opts)

      Cantrip.treesitter.get_installed(true)

      -- Install missing parsers
      local parsers_to_install = {}
      for _, lang in ipairs(opts.ensure_installed or {}) do
        if not Cantrip.treesitter.have(lang) then
          table.insert(parsers_to_install, lang)
        end
      end

      if #parsers_to_install > 0 then
        vim.notify("Installing treesitter parsers: " .. table.concat(parsers_to_install, ", "), vim.log.levels.INFO)
        vim.schedule(function()
          require("nvim-treesitter").install(parsers_to_install)
        end)
      end
    end,
  },
  -- {
  --   "m-demare/hlargs.nvim",
  --   dependencies = { "nvim-treesitter" },
  --   lazy = true,
  --   config = function(_, opts)
  --     require("hlargs").setup(opts)
  --     require("hlargs").enable()
  --   end,
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   dependencies = {
  --     {
  --       "windwp/nvim-ts-autotag",
  --       event = "VeryLazy",
  --     },
  --   },
  --   opts = {
  --     autotag = {
  --       enable = true,
  --     },
  --   },
  -- },
  -- {
  --   "folke/ts-comments.nvim",
  --   opts = {},
  --   event = "VeryLazy",
  --   enabled = vim.fn.has("nvim-0.10.0") == 1,
  -- },
  -- {
  --   "Wansmer/treesj",
  --   keys = { { "<space>m" }, { "<space>j" }, { "<space>s" } },
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   config = true,
  -- },
}
