local map = require("utils").map
local termcode = require("utils").termcode
local function prequire(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

local luasnip = prequire("luasnip")

-- Set completeopt to have a better completion experience

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

require("compe").setup({
  enabled = true,
  autocomplete = true,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    vsnip = true,
    snippets_nvim = true,
    treesitter = true,
  },
})

-- Use (s-)tab to:
--- move to prev/next item in completion menu
--- jump to prev/next snippet's placeholder

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return termcode("<C-n>")
  elseif luasnip.expand_or_jumpable() then
    return termcode("<Plug>luasnip-expand-or-jump")
  elseif check_back_space() then
    return termcode("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return termcode("<C-p>")
  elseif luasnip.jumpable(-1) then
    return termcode("<Plug>luasnip-jump-prev")
  else
    return termcode("<S-Tab>")
  end
end

-- Map tab to the above tab complete functions
map("i", "<silent><expr> <C-e>", "compe#close('<C-e>')", noremap)
map("i", "<silent><expr> <C-f>", "compe#scroll({ 'delta': +4 })", noremap)
map("i", "<silent><expr> <C-d>", "compe#scroll({ 'delta': -4 })", noremap)
map("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
map("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
map("i", "<silent><expr> <C-Space>", "compe#complete()", noremap)
map("i", "<silent><expr> <CR>", "compe#confirm('<CR>')", noremap)
