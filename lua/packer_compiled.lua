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
  ["caw.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/caw.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    after = { "nvim-lsp-installer" },
    loaded = true,
    only_config = true
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["cokeline.nvim"] = {
    config = { "require'config.bufferline'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/cokeline.nvim"
  },
  ["context_filetype.vim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/context_filetype.vim"
  },
  ["dashboard-nvim"] = {
    config = { 'require"config.dashboard"' },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["git-blame.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/git-blame.nvim"
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
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/impatient.nvim"
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
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
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
  ["null-ls.nvim"] = {
    config = { 'require"config.format"' },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { 'require"config.autopairs"' },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    config = { "require'config.lsp'" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "require'config.notify'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    config = { "require'config.tree'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
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
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag"
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
  ["telescope.nvim"] = {
    config = { 'require"config.telescope"' },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "require'config.trouble'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["twilight.nvim"] = {
    config = { "require'config.twilight'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/twilight.nvim"
  },
  ["vim-dogrun"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-dogrun"
  },
  ["vim-ft-diff_fold"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/vim-ft-diff_fold"
  },
  ["vim-ft-help_fold"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/vim-ft-help_fold"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-polyglot"] = {
    config = { "require'config.polyglot'" },
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-ruby-heredoc-syntax"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/opt/vim-ruby-heredoc-syntax"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "/Users/wuz/.local/share/nvim/site/pack/packer/start/vim-signify"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: indentLine
time([[Setup for indentLine]], true)
require"config.indentline"
time([[Setup for indentLine]], false)
time([[packadd for indentLine]], true)
vim.cmd [[packadd indentLine]]
time([[packadd for indentLine]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require'config.tree'
time([[Config for nvim-tree.lua]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require"config.telescope"
time([[Config for telescope.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require"config.autopairs"
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
require'config.notify'
time([[Config for nvim-notify]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: cmp-nvim-lsp
time([[Config for cmp-nvim-lsp]], true)
require"config.completion"
time([[Config for cmp-nvim-lsp]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('config.treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require'config.statusline'
time([[Config for lualine.nvim]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
require"config.dashboard"
time([[Config for dashboard-nvim]], false)
-- Config for: twilight.nvim
time([[Config for twilight.nvim]], true)
require'config.twilight'
time([[Config for twilight.nvim]], false)
-- Config for: cokeline.nvim
time([[Config for cokeline.nvim]], true)
require'config.bufferline'
time([[Config for cokeline.nvim]], false)
-- Config for: vim-polyglot
time([[Config for vim-polyglot]], true)
require'config.polyglot'
time([[Config for vim-polyglot]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
require'config.trouble'
time([[Config for trouble.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
require"config.format"
time([[Config for null-ls.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-lsp-installer ]]

-- Config for: nvim-lsp-installer
require'config.lsp'

time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType help ++once lua require("packer.load")({'vim-ft-help_fold'}, { ft = "help" }, _G.packer_plugins)]]
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'vim-ruby-heredoc-syntax'}, { ft = "ruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType diff ++once lua require("packer.load")({'vim-ft-diff_fold'}, { ft = "diff" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end