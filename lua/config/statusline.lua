local vim = vim

local function clock()
  return " " .. os.date("%H:%M")
end

local function lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏"
  }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

vim.cmd "autocmd User LspProgressUpdate let &ro = &ro"

require("lualine").setup {
  options = {
    theme = "calvera-nvim",
    icons_enabled = true,
    -- section_separators = {"", ""},
    -- component_separators = {"", ""}
    section_separators = {"", ""},
    component_separators = {"", ""}
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch"},
    lualine_c = {{"diagnostics", sources = {"nvim_lsp"}}, "filename"},
    lualine_x = {"filetype", lsp_progress},
    lualine_y = {clock}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}

-- local lsp_status = require('lsp-status')
--
-- local gl = require('galaxyline')
-- local gls = gl.section
-- local mode_fn = vim.fn.mode
-- local win_getid = vim.fn.win_getid
-- local winbufnr_fn = vim.fn.winbufnr
-- local bufname_fn = vim.fn.bufname
-- local fnamemod_fn = vim.fn.fnamemodify
-- local winwidth_fn = vim.fn.winwidth
-- local pathshorten_fn = vim.fn.pathshorten
--
-- local colors = {
--   bg = '#1a1c23',
--   yellow = '#FAB795',
--   cyan = '#59E3E3',
--   darkblue = '#081633',
--   green = '#29D398',
--   orange = '#FF8800',
--   purple = '#604e9d',
--   magenta = '#EE64AE',
--   grey = '#FADAD1',
--   blue = '#26BBD9',
--   red = '#E95678'
-- }
--
-- gl.short_line_list = {'LuaTree','vista','dbui'}
--
-- local checkwidth = function()
--   local squeeze_width  = vim.fn.winwidth(0) / 2
--   if squeeze_width > 40 then
--     return true
--   end
--   return false
-- end
--
-- local function lint_lsp(buf)
--   local result = ''
--   if #vim.lsp.buf_get_clients(buf) > 0 then result = result .. lsp_status.status() end
--   return result
-- end
--
-- local buffer_not_empty = function()
--   if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
--     return true
--   end
--   return false
-- end
--
-- local i = 0;
--
-- local function nextSeg()
--   i = i + 1
--   return i
-- end
--
-- gls.left[nextSeg()] = {
--   FirstElement = {
--     provider = function() return '  ' end,
--     highlight = {colors.darkblue,colors.bg}
--   },
-- }
--
-- gls.left[nextSeg()] ={
--   FileIcon = {
--     provider = 'FileIcon',
--     condition = buffer_not_empty,
--     separator = ' ',
--     separator_highlight = {colors.darkblue,colors.bg},
--     highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.darkblue},
--   },
-- }
--
-- gls.left[nextSeg()] = {
--   FileName = {
--     provider = {'FileName','FileSize'},
--     condition = buffer_not_empty,
--     separator = ' ',
--     separator_highlight = {colors.purple,colors.bg},
--     highlight = {colors.magenta,colors.bg}
--   }
-- }
--
-- gls.left[nextSeg()] = {
--   GitIcon = {
--     provider = function() return '   ' end,
--     condition = buffer_not_empty,
--     highlight = {colors.grey,colors.purple},
--   }
-- }
--
-- gls.left[nextSeg()] = {
--   GitBranch = {
--     provider = 'GitBranch',
--     condition = buffer_not_empty,
--     highlight = {colors.grey,colors.purple},
--   }
-- }
--
--
-- gls.left[nextSeg()] = {
--   DiffAdd = {
--     provider = 'DiffAdd',
--     condition = checkwidth,
--     icon = ' ',
--     highlight = {colors.green,colors.purple},
--   }
-- }
-- gls.left[nextSeg()] = {
--   DiffModified = {
--     provider = 'DiffModified',
--     condition = checkwidth,
--     icon = ' ',
--     highlight = {colors.orange,colors.purple},
--   }
-- }
-- gls.left[nextSeg()] = {
--   DiffRemove = {
--     provider = 'DiffRemove',
--     condition = checkwidth,
--     icon = ' ',
--     highlight = {colors.red,colors.purple},
--   }
-- }
-- gls.left[nextSeg()] = {
--   LeftEnd = {
--     provider = function() return '' end,
--     separator = '',
--     separator_highlight = {colors.purple,colors.bg},
--     highlight = {colors.purple,colors.purple}
--   }
-- }
-- gls.left[nextSeg()] = {
--   DiagnosticError = {
--     provider = 'DiagnosticError',
--     icon = '  ',
--     highlight = {colors.red,colors.bg}
--   }
-- }
--
-- gls.left[nextSeg()] = {
--   DiagnosticWarn = {
--     provider = 'DiagnosticWarn',
--     icon = '  ',
--     highlight = {colors.blue,colors.bg},
--   }
-- }
--
-- gls.left[nextSeg()] = {
--   LspStatus = {
--     provider = function()
--       local win_id = vim.fn.win_getid(win_num)
--       local buf_nr = vim.fn.winbufnr(win_id)
--       lint_lsp()
--     end,
--     condition = buffer_not_empty,
--     highlight = {colors.grey,colors.bg},
--   }
-- }
--
-- gls.right[1]= {
--   FileFormat = {
--     provider = 'FileFormat',
--     separator = ' ',
--     separator_highlight = {colors.bg,colors.purple},
--     highlight = {colors.grey,colors.purple},
--   }
-- }
--
-- gls.right[3] = {
--   PerCent = {
--     provider = 'LinePercent',
--     separator = ' ',
--     separator_highlight = {colors.purple,colors.darkblue},
--     highlight = {colors.grey,colors.darkblue},
--   }
-- }
-- gls.right[4] = {
--   ScrollBar = {
--     provider = 'ScrollBar',
--     highlight = {colors.yellow,colors.purple},
--   }
-- }
--
-- gls.short_line_left[1] = {
--   BufferType = {
--     provider = 'FileTypeName',
--     separator = ' ',
--     separator_highlight = {colors.bg,colors.purple},
--     highlight = {colors.grey,colors.purple}
--   }
-- }
--
--
-- gls.short_line_right[1] = {
--   BufferIcon = {
--     provider= 'BufferIcon',
--     separator = '',
--     separator_highlight = {colors.bg,colors.purple},
--     highlight = {colors.grey,colors.purple}
--   }
-- }
