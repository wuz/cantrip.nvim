-- imports
local cmd = vim.cmd
local autocmd = require "utils.autocmd"
local Boolean = require "utils.boolean"

local Cantrip = {}

Cantrip._config = {}

Cantrip._translucentBackground = function()
  cmd(
    [[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    set fillchars+=vert:\│
    highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
    ]]
  )
end

Cantrip._setTheme = function(theme)
  cmd("colorscheme " .. theme)
end

Cantrip._setLeader = function(leaderKey)
  vim.g.mapleader=leaderKey;
end

Cantrip._setLocalLeader = function(localLeaderKey)
  vim.g.maplocalleader=localLeaderKey;
end

Cantrip._normalize = function(config)
  config.theme = config.theme or "dogrun"
  config.leaderKey = config.leaderKey or " "
  config.localLeaderKey = config.localLeaderKey or "\\"
  config.translucent = Boolean.get(config.translucent, false)
  return config
end

Cantrip.setup = function(config)
  config = Cantrip._normalize(config)
  Cantrip._config = config

  Cantrip._setTheme(Cantrip._config["theme"])
  Cantrip._setLeader(Cantrip._config["leaderKey"])
  Cantrip._setLocalLeader(Cantrip._config["localLeaderKey"])
  if config.translucent then
    autocmd("CantripTranslucent", "ColorScheme * lua require'cantrip'._translucentBackground()")
  end
end

return Cantrip
