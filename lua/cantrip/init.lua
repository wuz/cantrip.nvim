local cmd = vim.cmd

vim.uv = vim.uv or vim.loop

local Boolean = require("cantrip.utils.boolean")
local autocmd = require("cantrip.utils.autocmd")
local cantrip_ui = require("cantrip.ui")

local M = {}

M._config = {}

M._translucentBackground = function()
  cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    set fillchars+=vert:\│
    highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
    ]])
end

M._setTheme = function(theme)
  cmd("colorscheme " .. theme)
end

M._normalize = function(config)
  config.theme = config.theme or "cantrip_dark"
  config.translucent = Boolean.get(config.translucent, false)
  config.lsp = config.lsp or {
    format = {},
  }
  config.lsp = config.notes or {}
  return config
end

M.getConfig = function()
  return M._config
end

M.init = function()
  require("cantrip.options")
  -- cantrip_ui.lsp_hover.setup {}
end

M.lazy_file = function()
  local Event = require("lazy.core.handler.event")

  -- We'll handle delayed execution of events ourselves
  Event.mappings.LazyFile = { id = "LazyFile", event = "User", pattern = "LazyFile" }
  Event.mappings["User LazyFile"] = Event.mappings.LazyFile
  local events = {} ---@type {event: string, buf: number, data?: any}[]

  local done = false
  local function load()
    if #events == 0 or done then
      return
    end
    done = true
    vim.api.nvim_del_augroup_by_name("lazy_file")

    ---@type table<string,string[]>
    local skips = {}
    for _, event in ipairs(events) do
      skips[event.event] = skips[event.event] or Event.get_augroups(event.event)
    end

    vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile", modeline = false })
    for _, event in ipairs(events) do
      if vim.api.nvim_buf_is_valid(event.buf) then
        Event.trigger {
          event = event.event,
          exclude = skips[event.event],
          data = event.data,
          buf = event.buf,
        }
        if vim.bo[event.buf].filetype then
          Event.trigger {
            event = "FileType",
            buf = event.buf,
          }
        end
      end
    end
    vim.api.nvim_exec_autocmds("CursorMoved", { modeline = false })
    events = {}
  end

  -- schedule wrap so that nested autocmds are executed
  -- and the UI can continue rendering without blocking
  load = vim.schedule_wrap(load)

  vim.api.nvim_create_autocmd(M.lazy_file_events, {
    group = vim.api.nvim_create_augroup("lazy_file", { clear = true }),
    callback = function(event)
      table.insert(events, event)
      load()
    end,
  })
end

M.setup = function(config)
  require("cantrip.keymaps")
  config = M._normalize(config)
  M._config = config

  M._setTheme(config.theme)
  if config.translucent then
    autocmd("MTranslucent", "ColorScheme * lua require'cantrip'._translucentBackground()")
  end
  M.init()
end

return M
