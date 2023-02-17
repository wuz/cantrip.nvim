return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      autopairs = { enable = true },
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
        "bash",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "query",
        "regex",
        "tsx",
        "vim",
        "yaml",
        "ruby",
        "scss",
        "css",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { "nvim-treesitter/nvim-treesitter-refactor", dependencies = { "nvim-treesitter" } },
  { "JoosepAlviste/nvim-ts-context-commentstring", dependencies = { "nvim-treesitter" } },
  { "RRethy/nvim-treesitter-textsubjects", dependencies = { "nvim-treesitter" } },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter" } },
  { "windwp/nvim-ts-autotag", dependencies = { "nvim-treesitter" } },
  {
    "abecodes/tabout.nvim",
    opts = {
      tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = true, -- shift content if tab out is not possible
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
      enable_backwards = true, -- well ...
      completion = true, -- if the tabkey is used in a completion pum
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
      },
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
      exclude = {}, -- tabout will ignore these filetypes
    },
    config = function(_, opts)
      require("tabout").setup(opts)
    end,
    dependencies = {
      "nvim-treesitter", -- "nvim-cmp"
    },
  },
}
