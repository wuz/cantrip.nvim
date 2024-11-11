return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>",      desc = "Schrink selection",  mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      tree_docs = {
        enable = true,
      },
      refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "grr",
          },
        },
        navigation = {
          enable = true,
          keymaps = {
            goto_definition = "gnd",
            list_definitions = "gnD",
            list_definitions_toc = "gO",
            goto_next_usage = "<a-*>",
            goto_previous_usage = "<a-#>",
          },
        },
      },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
      },
      autotag = {
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
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ak"] = { query = "@block.outer", desc = "around block" },
            ["ik"] = { query = "@block.inner", desc = "inside block" },
            ["ac"] = { query = "@class.outer", desc = "around class" },
            ["ic"] = { query = "@class.inner", desc = "inside class" },
            ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
            ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
            ["af"] = { query = "@function.outer", desc = "around function " },
            ["if"] = { query = "@function.inner", desc = "inside function " },
            ["ao"] = { query = "@loop.outer", desc = "around loop" },
            ["io"] = { query = "@loop.inner", desc = "inside loop" },
            ["aa"] = { query = "@parameter.outer", desc = "around argument" },
            ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]k"] = { query = "@block.outer", desc = "Next block start" },
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
          },
          goto_next_end = {
            ["]K"] = { query = "@block.outer", desc = "Next block end" },
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
          },
          goto_previous_start = {
            ["[k"] = { query = "@block.outer", desc = "Previous block start" },
            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
          },
          goto_previous_end = {
            ["[K"] = { query = "@block.outer", desc = "Previous block end" },
            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            [">K"] = { query = "@block.outer", desc = "Swap next block" },
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
            [">A"] = { query = "@parameter.inner", desc = "Swap next argument" },
          },
          swap_previous = {
            ["<K"] = { query = "@block.outer", desc = "Swap previous block" },
            ["<F"] = { query = "@function.outer", desc = "Swap previous function" },
            ["<A"] = { query = "@parameter.inner", desc = "Swap previous argument" },
          },
        },
      },
    },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
      require("lazy.core.loader").add_to_rtp(plugin)
      pcall(require, "nvim-treesitter.query_predicates")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require("nvim-treesitter.install").prefer_git = true
      require("ts_context_commentstring").setup({})
      vim.g.skip_ts_context_commentstring_module = true
      local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      for _, p in pairs(parsers) do
        p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
      end
    end,
  },
  { "nvim-treesitter/nvim-treesitter-refactor",    dependencies = { "nvim-treesitter" }, lazy = true },
  { "JoosepAlviste/nvim-ts-context-commentstring", dependencies = { "nvim-treesitter" }, lazy = true },
  { "RRethy/nvim-treesitter-textsubjects",         dependencies = { "nvim-treesitter" }, lazy = true },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter" }, lazy = true },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter" },
    lazy = true,
    init = function()
      if vim.fn.has("nvim-0.10") == 1 then
        -- HACK: add workaround for native comments: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/109
        vim.schedule(function()
          local get_option = vim.filetype.get_option
          local context_commentstring
          vim.filetype.get_option = function(filetype, option)
            if option ~= "commentstring" then
              return get_option(filetype, option)
            end
            if context_commentstring == nil then
              local ts_context_avail, ts_context = pcall(require, "ts_context_commentstring.internal")
              context_commentstring = ts_context_avail and ts_context
            end
            return context_commentstring and context_commentstring.calculate_commentstring()
                or get_option(filetype, option)
          end
        end)
      end
    end,
    opts = { enable_autocmd = false },
  },
  { "mrjones2014/nvim-ts-rainbow",    dependencies = { "nvim-treesitter" }, lazy = true },
  { "nvim-treesitter/nvim-tree-docs", dependencies = { "nvim-treesitter" }, lazy = true },
}
