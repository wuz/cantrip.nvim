local map = require "utils".map

-- Set completeopt to have a better completion experience

-- Utility functions for compe and luasnip
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col "." - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
    return true
  else
    return false
  end
end

require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    snippets_nvim = true,
    treesitter = true
  }
}

-- Use (s-)tab to:
--- move to prev/next item in completion menu
--- jump to prev/next snippet's placeholder
local luasnip = require "luasnip"

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif luasnip.expand_or_jumpable() then
    return t "<Plug>luasnip-expand-or-jump"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif luasnip.jumpable(-1) then
    return t "<Plug>luasnip-jump-prev"
  else
    return t "<S-Tab>"
  end
end

-- Map tab to the above tab complete functions
map("i", "<silent><expr> <C-e>", "compe#close('<C-e>')", noremap)
map("i", "<silent><expr> <C-f>", "compe#scroll({ 'delta': +4 })", noremap)
map("i", "<silent><expr> <C-d>", "compe#scroll({ 'delta': -4 })", noremap)
map("i", "<Tab>", "v:lua.tab_complete()", expr)
map("s", "<Tab>", "v:lua.tab_complete()", expr)
map("i", "<S-Tab>", "v:lua.s_tab_complete()", expr)
map("s", "<S-Tab>", "v:lua.s_tab_complete()", expr)
map("i", "<silent><expr> <C-Space>", "compe#complete()", noremap)
map("i", "<silent><expr> <CR>", "compe#confirm('<CR>')", noremap)
