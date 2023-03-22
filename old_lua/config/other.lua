local autocmd = vim.api.nvim_create_autocmd
local M = {}

-- TODO: Refactor most of these to use lua configuration over viml

M.comment = function()
  require("Comment").setup({
    pre_hook = function(ctx)
      local U = require("Comment.utils")
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring({
        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
        location = location,
      })
    end,
  })
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

M.icons = function()
  require("nvim-web-devicons").setup({
    default = true,
  })
end

M.marks = function()
  require("marks").setup({
    default_mappings = true,
    excluded_filetypes = { "packer", "dashboard" },
  })
end

M.lastplace = function()
  require("nvim-lastplace").setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", "NvimTree", "packer" },
    lastplace_open_folds = true,
  })
end

M.quickscope = function()
  vim.cmd([[
      nmap <leader>q <plug>(QuickScopeToggle)
      xmap <leader>q <plug>(QuickScopeToggle)
      let g:qs_buftype_blacklist = ['terminal', 'nofile']
      let g:qs_filetype_blacklist = ['dashboard', 'packer']
  ]])
end

return M
