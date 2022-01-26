local M = {}

M.comment = function()
  require("Comment").setup()
end

M.kind_symbols = function()
  return {
    Text = "",
    Method = "Ƒ",
    Function = "ƒ",
    Constructor = "",
    Variable = "",
    Class = "",
    Interface = "ﰮ",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "了",
    Keyword = "",
    Snippet = "﬌",
    Color = "",
    File = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
  }
end

M.todo = function()
  require("todo-comments").setup({})
end

return M
