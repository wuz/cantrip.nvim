-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/wuz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/wuz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/wuz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/wuz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/wuz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["barbar.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["calvera-dark.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/calvera-dark.nvim"
  },
  ["caw.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/caw.vim"
  },
  ["context_filetype.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/context_filetype.vim"
  },
  ["dashboard-nvim"] = {
    config = { "require'config.dashboard'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["fern-git-status.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/fern-git-status.vim"
  },
  ["fern-hijack.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/fern-hijack.vim"
  },
  ["fern-mapping-git.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/fern-mapping-git.vim"
  },
  ["fern-preview.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/fern-preview.vim"
  },
  ["fern-renderer-nerdfont.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/fern-renderer-nerdfont.vim"
  },
  ["fern.vim"] = {
    config = { "require'config.fern'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/fern.vim"
  },
  ["formatter.nvim"] = {
    config = { "require('config.format')" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["gina.vim"] = {
    config = { "require('config.gina')" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/gina.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glyph-palette.vim"] = {
    config = { "require('config.glyph')" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/glyph-palette.vim"
  },
  indentLine = {
    after_files = { "/Users/wuz/.local/share/nvim/site/pack/packer/opt/indentLine/after/plugin/indentLine.vim" },
    loaded = true,
    needs_bufread = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/indentLine"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "require'config.statusline'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["nerdfont.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nerdfont.vim"
  },
  ["nvim-bufdel"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-bufdel"
  },
  ["nvim-colorizer.lua"] = {
    config = { "require('colorizer').setup {'css', 'javascript', 'vim', 'html'}" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    config = { "require('config.compe')" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    config = { "require'config.lightbulb'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    config = { "require'config.lsp'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    config = { "require('config.treesitter')" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rename.vim"] = {
    commands = { "Rename" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/rename.vim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope.nvim"] = {
    config = { "require('config.telescope')" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  vim = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-asterisk"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-asterisk"
  },
  ["vim-bbye"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-bbye"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-closer"
  },
  ["vim-conflicted"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-conflicted"
  },
  ["vim-css-color"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/vim-css-color"
  },
  ["vim-easy-align"] = {
    config = { "require('config.easy_align')" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-endwise"
  },
  ["vim-esearch"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-esearch"
  },
  ["vim-ft-diff_fold"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/vim-ft-diff_fold"
  },
  ["vim-ft-help_fold"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/vim-ft-help_fold"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-horizon"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-horizon"
  },
  ["vim-misc"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-misc"
  },
  ["vim-move"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-move"
  },
  ["vim-nazgul"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-nazgul"
  },
  ["vim-polyglot"] = {
    config = { "require'config.polyglot'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-ref"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-ref"
  },
  ["vim-reload"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-reload"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-ruby-heredoc-syntax"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-ruby-heredoc-syntax"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-signify"
  },
  ["vim-subversive"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-subversive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-wordmotion"
  },
  ["which-key.nvim"] = {
    config = { "require'config.which_key'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: indentLine
time([[Setup for indentLine]], true)
require('config.indentline')
time([[Setup for indentLine]], false)
time([[packadd for indentLine]], true)
vim.cmd [[packadd indentLine]]
time([[packadd for indentLine]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
require('config.format')
time([[Config for formatter.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: vim-polyglot
time([[Config for vim-polyglot]], true)
require'config.polyglot'
time([[Config for vim-polyglot]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require'config.lsp'
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-compe
time([[Config for nvim-compe]], true)
require('config.compe')
time([[Config for nvim-compe]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
require'config.dashboard'
time([[Config for dashboard-nvim]], false)
-- Config for: nvim-lightbulb
time([[Config for nvim-lightbulb]], true)
require'config.lightbulb'
time([[Config for nvim-lightbulb]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('config.treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('config.telescope')
time([[Config for telescope.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
require('config.easy_align')
time([[Config for vim-easy-align]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require'config.statusline'
time([[Config for lualine.nvim]], false)
-- Config for: glyph-palette.vim
time([[Config for glyph-palette.vim]], true)
require('config.glyph')
time([[Config for glyph-palette.vim]], false)
-- Config for: gina.vim
time([[Config for gina.vim]], true)
require('config.gina')
time([[Config for gina.vim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
require'config.which_key'
time([[Config for which-key.nvim]], false)
-- Config for: fern.vim
time([[Config for fern.vim]], true)
require'config.fern'
time([[Config for fern.vim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command! -nargs=* -range -bang -complete=file Rename lua require("packer.load")({'rename.vim'}, { cmd = "Rename", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType diff ++once lua require("packer.load")({'vim-ft-diff_fold'}, { ft = "diff" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'vim-css-color'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'vim-css-color', 'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType less ++once lua require("packer.load")({'vim-css-color'}, { ft = "less" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType help ++once lua require("packer.load")({'vim-ft-help_fold'}, { ft = "help" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType sass ++once lua require("packer.load")({'vim-css-color'}, { ft = "sass" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "javascript" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
