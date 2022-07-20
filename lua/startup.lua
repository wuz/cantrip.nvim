local autocmd = vim.api.nvim_create_autocmd
require "defaults.global"
require "defaults.functionality"
require "defaults.folding"
require "defaults.completion"
require "defaults.search"
require "defaults.wildmenu"
require "defaults.appearance"

require "maps"

-- disable builtin plugins

local default_plugins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(default_plugins) do
   vim.g["loaded_" .. plugin] = 1
end

autocmd("BufReadPost", {
   callback = function()
      if not vim.fn.expand("%:p"):match ".git" and vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
         vim.cmd "normal! g'\""
         vim.cmd "normal zz"
      end
   end,
})
