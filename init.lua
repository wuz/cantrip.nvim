-- Don't edit this file! If you want to change your settings, you're probably looking for
-- the `lua/cantriprc.lua` file!

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/nvim/?.lua"

require("startup")
require("plugins")
require("cantriprc")
