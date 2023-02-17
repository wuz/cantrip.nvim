-- imports
local cmd = vim.cmd
local autocmd = require("cantrip.utils.autocmd")
local Boolean = require("cantrip.utils.boolean")

local Cantrip = {}

Cantrip._config = {}

Cantrip._translucentBackground = function()
  cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    set fillchars+=vert:\│
    highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
    ]])
end

Cantrip._setTheme = function(theme)
  cmd("colorscheme " .. theme)
end

Cantrip._normalize = function(config)
  config.theme = config.theme or "eldritch"
  config.translucent = Boolean.get(config.translucent, false)
  config.lsp = config.lsp or {
        format = {},
      }
  config.lsp = config.notes or {}
  return config
end

Cantrip.getConfig = function()
  return Cantrip._config
end

Cantrip.init = function()
  require("cantrip.config.options")
end

Cantrip.setup = function(config)
  require("cantrip.config.keymaps")
  config = Cantrip._normalize(config)
  Cantrip._config = config

  Cantrip._setTheme(Cantrip._config["theme"])
  if config.translucent then
    autocmd("CantripTranslucent", "ColorScheme * lua require'cantrip'._translucentBackground()")
  end
end

return Cantrip
