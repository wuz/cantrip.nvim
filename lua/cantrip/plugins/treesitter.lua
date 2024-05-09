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
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      tree_docs = {
        enable = true,
        spec_config = {
          jsdoc = {
            slots = {
              class = { description = true },
            },
          },
        },
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
    },
    ---@param opts TSConfig
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
  { "nvim-treesitter/nvim-treesitter-refactor",    dependencies = { "nvim-treesitter" } },
  { "JoosepAlviste/nvim-ts-context-commentstring", dependencies = { "nvim-treesitter" } },
  { "RRethy/nvim-treesitter-textsubjects",         dependencies = { "nvim-treesitter" } },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter" } },
  { "windwp/nvim-ts-autotag",                      dependencies = { "nvim-treesitter" } },
  { "mrjones2014/nvim-ts-rainbow",                 dependencies = { "nvim-treesitter" } },
  { "nvim-treesitter/nvim-tree-docs",              dependencies = { "nvim-treesitter" } },
}
