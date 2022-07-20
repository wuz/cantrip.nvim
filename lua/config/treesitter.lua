require("nvim-treesitter.configs").setup({
  ensure_installed = {
		"lua",
		"bash",
		"javascript",
		"typescript",
		"json",
		"yaml",
		"html",
		"ruby",
		"vim",
		"markdown",
		"scss",
		"css"
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },
  autotag = {
    enable = true,
  },
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
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
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
})
require("nvim-treesitter.install").prefer_git = true
local parsers = require("nvim-treesitter.parsers").get_parser_configs()
for _, p in pairs(parsers) do
	p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
end
