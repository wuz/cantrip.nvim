require "defaults.global"
require "defaults.functionality"
require "defaults.folding"
require "defaults.completion"
require "defaults.search"
require "defaults.wildmenu"
require "defaults.appearance"

require "maps"

require "disable"

local autocmd = require "utils.autocmd"
autocmd("Config", "BufWritePost lua/*.lua luafile %")
autocmd("Config", "BufWritePost cantriprc.lua luafile %")
