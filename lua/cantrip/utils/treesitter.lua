local M = {}

---@class InstallInfo

---@class TreesitterLanguage
---@field language string
---@field filetypes { [string]: string }
---@field install_info InstallInfo

---@param language TreesitterLanguage
M.register_language = function(language)
  local parsers = require("nvim-treesitter.parsers")
  for extension, filetype in pairs(language.filetypes) do
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers")[language.language] = {
          install_info = language.install_info,
          filetype = filetype,
        }
      end,
    })
    vim.treesitter.language.register(filetype, { extension })
  end
  vim.filetype.add({
    extension = filetypes,
  })
end

M._installed = nil ---@type table<string,boolean>?
M._queries = {} ---@type table<string,boolean>

---@param update boolean?
M.get_installed = function(update)
  if update then
    M._installed, M._queries = {}, {}
    for _, lang in ipairs(require("nvim-treesitter").get_installed("parsers")) do
      M._installed[lang] = true
    end
  end
  return M._installed or {}
end

---@param lang string
---@param query string
M.have_query = function(lang, query)
  local key = lang .. ":" .. query
  if M._queries[key] == nil then
    M._queries[key] = vim.treesitter.query.get(lang, query) ~= nil
  end
  return M._queries[key]
end

---@param what string|number|nil
---@param query? string
---@overload fun(buf?:number):boolean
---@overload fun(ft:string):boolean
---@return boolean
M.have = function(what, query)
  what = what or vim.api.nvim_get_current_buf()
  what = type(what) == "number" and vim.bo[what].filetype or what --[[@as string]]
  local lang = vim.treesitter.language.get_lang(what)
  if lang == nil or M.get_installed()[lang] == nil then
    return false
  end
  if query and not M.have_query(lang, query) then
    return false
  end
  return true
end

return M
