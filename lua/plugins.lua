local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local execute = vim.api.nvim_command
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute('packadd packer.nvim')
end
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  -- ┌───────────────────────────────────────────────────────────────────────────────────┐
  -- │ █▓▒░ Packer/Lua                                                                   │
  -- └───────────────────────────────────────────────────────────────────────────────────┘
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}
  -- use {'svermeulen/nvim-moonmaker'}

  -- ┌───────────────────────────────────────────────────────────────────────────────────┐
  -- │ █▓▒░ Main                                                                         │
  -- └───────────────────────────────────────────────────────────────────────────────────┘

  use { 'ntk148v/vim-horizon' }
  use { 'ryanoasis/vim-devicons' }
  use {
    'onsails/lspkind-nvim', 'neovim/nvim-lspconfig', '~/projects/personal/lsp-status.nvim', {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor', 'nvim-treesitter/nvim-treesitter-textobjects'
      },
      config = [[require('config.treesitter')]]
    }
  }
  use { 'https://git.sr.ht/~wuz/scuttle.vim', config = [[require('config.scuttle')]] }

  -- ┌───────────────────────────────────────────────────────────────────────────────────┐
  -- │ █▓▒░ Lazy                                                                         │
  -- └───────────────────────────────────────────────────────────────────────────────────┘
end)


-- local int_to_bool = { [0] = false, [1] = true }
-- 
-- local plugins_dir = fn.expand('~/.config/nvim/dein')
-- 
-- local dein_dir = fn.finddir('dein.vim', '.;')
-- 
-- local Dein = {}
-- 
-- function Dein.option(name, value)
--  vim.api.nvim_set_var('dein#'..name, value)
-- end
-- 
-- function Dein.load_state(path)
--  return vim.call('dein#load_state', path)
-- end
-- 
-- function Dein.begin(path, options)
--  return vim.call('dein#begin', path, '['..table.concat(options, ',')..']')
-- end
-- 
-- function Dein.load_toml(path, options)
--   return vim.call('dein#load_toml', path, options)
-- end
-- 
-- function Dein.stop()
--  return vim.call('dein#end')
-- end
-- 
-- function Dein.save_state()
--  return vim.call('dein#save_state')
-- end
-- 
-- function Dein.call_hook(hook)
--  return vim.call('dein#call_hook', hook)
-- end
-- 
-- function Dein.check_install()
--  return vim.call('dein#check_install') ~= 0
-- end
-- 
-- function Dein.install()
--  return vim.call('dein#install')
-- end
-- 
-- local dein_cache = fn.expand('$CACHE/dein')
-- 
-- if dein_dir ~= '' or not string.find(o.runtimepath, '/dein.vim') then
-- 	if dein_dir == '' and not string.find(o.runtimepath, '/dein.vim') then
--     		dein_dir = fn.expand(dein_cache..'/repos/github.com/Shougo/dein.vim/')
-- 		if not fn.isdirectory(dein_dir) then
-- 			fn.execute('!git clone https://github.com/Shougo/dein.vim '..dein_dir) 
-- 		end
-- 	end
-- 	o.runtimepath = o.runtimepath ..','.. fn.fnamemodify(dein_dir, ':p'):gsub('/$','')
-- end
-- 
-- Dein.option('install_progress_type', 'title')
-- Dein.option('enable_notification', 1)
-- Dein.option('auto_recache', 1)
-- Dein.option('install_log_filename', '~/dein.log')
-- 
-- local default_toml = plugins_dir..'/default.toml'
-- local ft_toml = plugins_dir..'/filetype.toml'
-- local lazy_toml = plugins_dir..'/lazy.toml'
-- 
-- if Dein.load_state(dein_cache) then
-- 
-- 	Dein.begin(dein_cache, {'~/.config/nvim/init.lua', fn.expand('<sfile>'), default_toml, lazy_toml, ft_toml})
-- 
-- 	Dein.load_toml(default_toml, { lazy = 0 })
-- 	Dein.load_toml(lazy_toml, { lazy = 1 })
-- 	Dein.load_toml(ft_toml)
-- 
-- 	Dein.stop()
-- 	Dein.save_state()
-- end
-- 
-- if not int_to_bool[fn.has('vim_starting')] and Dein.check_install() then
-- 	Dein.install()
-- end
