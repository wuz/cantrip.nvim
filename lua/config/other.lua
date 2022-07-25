local autocmd = vim.api.nvim_create_autocmd
local M = {}

-- TODO: Refactor most of these to use lua configuration over viml

M.fidget = function()
  require("fidget").setup()
end

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

M.dap = function()
  require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
    },
    layouts = {
      {
        elements = {
          'scopes',
          'breakpoints',
          'stacks',
          'watches',
        },
        size = 40,
        position = 'left',
      },
      {
        elements = {
          'repl',
          'console',
        },
        size = 10,
        position = 'bottom',
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
  })
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

M.todo = function()
  require("todo-comments").setup()
end

M.lastplace = function()
  require("nvim-lastplace").setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", "NvimTree", "packer" },
    lastplace_open_folds = true,
  })
end

M.test = function()
  require('neotest').setup({
      adapters = {
        require("neotest-vim-test")({ ignore_filetypes = { "python", "javascript", "typescript" } }),
        require('neotest-rspec'),
        require('neotest-jest'),
      }
    })
  -- autocmd("BufWritePost", {
  --    callback = function()
  --       require("neotest").run.run({strategy = "dap"})
  --    end,
  -- })
end

M.quickscope = function()
  vim.cmd([[
      nmap <leader>q <plug>(QuickScopeToggle)
      xmap <leader>q <plug>(QuickScopeToggle)
      let g:qs_buftype_blacklist = ['terminal', 'nofile']
      let g:qs_filetype_blacklist = ['dashboard', 'packer']
  ]])
end

M.tabout = function()
  require("tabout").setup({
    tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
    act_as_tab = true, -- shift content if tab out is not possible
    act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    enable_backwards = true, -- well ...
    completion = true, -- if the tabkey is used in a completion pum
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
    },
    ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {}, -- tabout will ignore these filetypes
  })
end

return M
