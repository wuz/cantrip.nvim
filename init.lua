-- Don't edit this file! If you want to change your settings, you're probably looking for
-- the `lua/cantriprc.lua` file!

package.path = package.path .. ";"..os.getenv("HOME").."/.config/nvim/?.lua"

require "startup"
require "cantriprc"

require "impatient".enable_profile()
require "packer_compiled"
require "plugins"
