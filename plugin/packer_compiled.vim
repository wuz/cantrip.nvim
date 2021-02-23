" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/conlindurbin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/conlindurbin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/conlindurbin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/conlindurbin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/conlindurbin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ["caw.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/caw.vim"
  },
  ["context_filetype.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/context_filetype.vim"
  },
  ["fern-git-status.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/fern-git-status.vim"
  },
  ["fern-mapping-git.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/fern-mapping-git.vim"
  },
  ["fern-renderer-nerdfont.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/fern-renderer-nerdfont.vim"
  },
  ["fern.vim"] = {
    config = { "require'config.fern'" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/fern.vim"
  },
  firenvim = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  ["formatter.nvim"] = {
    config = { "require('config.format')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  fzf = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf-mru.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/fzf-mru.vim"
  },
  ["fzf-preview.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/fzf-preview.vim"
  },
  ["fzf.vim"] = {
    config = { "require('config.fzf')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["galaxyline.nvim"] = {
    config = { "require'config.statusline'" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gina.vim"] = {
    config = { "require('config.gina')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/gina.vim"
  },
  ["git-messenger.vim"] = {
    commands = { "GitMessenger" },
    keys = { { "", "<Plug>(git-messenger)" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glyph-palette.vim"] = {
    config = { "require('config.glyph')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/glyph-palette.vim"
  },
  indentLine = {
    after_files = { "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/indentLine/after/plugin/indentLine.vim" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/indentLine"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["nerdfont.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nerdfont.vim"
  },
  ["nvim-bufdel"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-bufdel"
  },
  ["nvim-colorizer.lua"] = {
    config = { "require('colorizer').setup {'css', 'javascript', 'vim', 'html'}" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "require('config.compe')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    config = { "require'config.lightbulb'" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    config = { "require'config.lsp'" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    config = { "require('config.treesitter')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["rename.vim"] = {
    commands = { "Rename" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/rename.vim"
  },
  scuttle = {
    config = { "require('config.scuttle')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/scuttle"
  },
  ["searchReplace.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/searchReplace.vim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-agriculture"] = {
    config = { "require('config.agriculture')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-agriculture"
  },
  ["vim-asterisk"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-asterisk"
  },
  ["vim-bbye"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-bbye"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-closer"
  },
  ["vim-conflicted"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-conflicted"
  },
  ["vim-css-color"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/vim-css-color"
  },
  ["vim-easy-align"] = {
    config = { "require('config.easy_align')" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-endwise"
  },
  ["vim-esearch"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-esearch"
  },
  ["vim-ft-diff_fold"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/vim-ft-diff_fold"
  },
  ["vim-ft-help_fold"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/vim-ft-help_fold"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-horizon"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-horizon"
  },
  ["vim-misc"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-misc"
  },
  ["vim-move"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-move"
  },
  ["vim-nazgul"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-nazgul"
  },
  ["vim-polyglot"] = {
    config = { "require'config.polyglot'" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-ref"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-ref"
  },
  ["vim-reload"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-reload"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-signify"
  },
  ["vim-startify"] = {
    config = { "require'config.startify'" },
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-subversive"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-subversive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    after_files = { "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ/after/plugin/vsnip_integ.vim" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  },
  warlock = {
    loaded = true,
    path = "/Users/conlindurbin/.local/share/nvim/site/pack/packer/start/warlock"
  }
}

-- Setup for: indentLine
require('config.indentline')
vim.cmd [[packadd indentLine]]
-- Config for: vim-startify
require'config.startify'
-- Config for: vim-easy-align
require('config.easy_align')
-- Config for: gina.vim
require('config.gina')
-- Config for: vim-polyglot
require'config.polyglot'
-- Config for: nvim-lightbulb
require'config.lightbulb'
-- Config for: scuttle
require('config.scuttle')
-- Config for: nvim-lspconfig
require'config.lsp'
-- Config for: fern.vim
require'config.fern'
-- Config for: fzf.vim
require('config.fzf')
-- Config for: vim-agriculture
require('config.agriculture')
-- Config for: galaxyline.nvim
require'config.statusline'
-- Config for: nvim-web-devicons
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
-- Config for: formatter.nvim
require('config.format')
-- Config for: gitsigns.nvim
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
-- Config for: nvim-treesitter
require('config.treesitter')
-- Config for: glyph-palette.vim
require('config.glyph')
-- Config for: nvim-compe
require('config.compe')

-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file Rename lua require("packer.load")({'rename.vim'}, { cmd = "Rename", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file GitMessenger lua require("packer.load")({'git-messenger.vim'}, { cmd = "GitMessenger", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

-- Keymap lazy-loads
vim.cmd [[noremap <silent> <Plug>(git-messenger) <cmd>lua require("packer.load")({'git-messenger.vim'}, { keys = "<lt>Plug>(git-messenger)", prefix = "" }, _G.packer_plugins)<cr>]]

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType diff ++once lua require("packer.load")({'vim-ft-diff_fold'}, { ft = "diff" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'vim-css-color'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType sass ++once lua require("packer.load")({'vim-css-color'}, { ft = "sass" }, _G.packer_plugins)]]
vim.cmd [[au FileType less ++once lua require("packer.load")({'vim-css-color'}, { ft = "less" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType help ++once lua require("packer.load")({'vim-ft-help_fold'}, { ft = "help" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-css-color', 'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
