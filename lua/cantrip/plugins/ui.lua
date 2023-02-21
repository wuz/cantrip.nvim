local g = vim.g

return {
  {
    "stevearc/dressing.nvim",
  },
  {
    "mawkler/modicator.nvim",
    dependencies = "folke/tokyonight.nvim",
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    config = function()
      require("modicator").setup()
    end,
  },
  { "famiu/bufdelete.nvim" },
  {
    "echasnovski/mini.cursorword",
    version = false,
    config = function()
      require("mini.cursorword").setup()
    end,
  },
  {
    "echasnovski/mini.trailspace",
    version = false,
    config = function()
      require("mini.trailspace").setup()
    end,
  },
  {
    "nkakouros-original/numbers.nvim",
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<C-h>", ":BufferLineCyclePrev<CR>" },
      { "<C-l>", ":BufferLineCycleNext<CR>" },
    },
    opts = {
      options = {
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        modified_icon = "",
        show_close_icon = false,
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        separator_style = "thick",
        always_show_bufferline = true,
        diagnostics = false,
      },
    },
  },
  {
    "kyazdani42/nvim-tree.lua",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeFocus",
      "NvimTreeToggle",
      "NvimTreeFindFileToggle",
    },
    keys = {
      { "<Leader>/", ":NvimTreeFindFileToggle <CR>" },
    },
    dependencies = { { "nvim-tree/nvim-web-devicons", event = "VeryLazy" } },
    opts = function()
      local list = {
        { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
        { key = "<C-e>", action = "edit_in_place" },
        { key = { "O" }, action = "edit_no_picker" },
        { key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
        { key = "<C-v>", action = "vsplit" },
        { key = "<C-x>", action = "split" },
        { key = "<C-t>", action = "tabnew" },
        { key = "<", action = "prev_sibling" },
        { key = ">", action = "next_sibling" },
        { key = "P", action = "parent_node" },
        { key = "<BS>", action = "close_node" },
        { key = "<Tab>", action = "preview" },
        { key = "K", action = "first_sibling" },
        { key = "J", action = "last_sibling" },
        { key = "I", action = "toggle_git_ignored" },
        { key = "H", action = "toggle_dotfiles" },
        { key = "R", action = "refresh" },
        { key = "n", action = "create" },
        { key = "d", action = "remove" },
        { key = "D", action = "trash" },
        { key = "r", action = "rename" },
        { key = "<C-r>", action = "full_rename" },
        { key = "x", action = "cut" },
        { key = "c", action = "copy" },
        { key = "p", action = "paste" },
        { key = "y", action = "copy_name" },
        { key = "Y", action = "copy_path" },
        { key = "gy", action = "copy_absolute_path" },
        { key = "[c", action = "prev_git_item" },
        { key = "]c", action = "next_git_item" },
        { key = "-", action = "dir_up" },
        { key = "s", action = "system_open" },
        { key = "q", action = "close" },
        { key = "?", action = "toggle_help" },
        { key = "W", action = "collapse_all" },
        { key = "S", action = "search_node" },
        { key = "<C-k>", action = "toggle_file_info" },
        { key = ".", action = "run_file_command" },
      }
      return {
        open_on_tab = true,
        hijack_cursor = true,
        view = {
          hide_root_folder = true,
          mappings = {
            list = list,
          },
        },
      }
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      g.nvim_tree_highlight_opened_files = 0
      g.nvim_tree_root_folder_modifier = table.concat({ ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" })

      g.nvim_tree_show_icons = {
        folders = 1,
        -- folder_arrows= 1
        files = 1,
        git = 1,
      }

      g.nvim_tree_icons = {
        default = "",
        symlink = "",
        git = {
          deleted = "",
          ignored = "◌",
          renamed = "➜",
          staged = "✓",
          unmerged = "",
          unstaged = "✗",
          untracked = "",
        },
        folder = {
          -- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
          -- arrow_open = "",
          -- arrow_closed = "",
          default = "",
          empty = "", -- 
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
        },
      }
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()

      vim.cmd([[
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>

" use : instead of <Cmd>
nnoremap <silent> <leader>l :noh<CR>
]])
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufEnter",
    opts = {
      css = { css = true },
      lua = { css = true },
      typescript = { css = true },
      javascript = { css = true },
      typescriptreact = { css = true },
      javascriptreact = { css = true },
      html = { css = true },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    opts = {
      char = "",
      show_trailing_blankline_indent = false,
    },
    config = function(_, opts)
      vim.cmd([[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]])

      vim.opt.list = true
      vim.opt.listchars:append("eol:↴")

      require("indent_blankline").setup(opts)
    end,
  },
  {
    "winston0410/range-highlight.nvim",
    dependencies = { "winston0410/cmd-parser.nvim" },
  },
  {
    "karb94/neoscroll.nvim",
  },
  {
    "petertriho/nvim-scrollbar",
    opts = function()
      local colors = require("tokyonight.colors").setup()
      return {
        handle = {
          color = colors.bg_highlight,
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
        },
        handlers = {
          diagnostic = true,
          search = true,
        },
      }
    end,
    config = function(_, opts)
      require("scrollbar").setup(opts)
      require("scrollbar.handlers.search").setup()
    end,
  },
  {
    "hoob3rt/lualine.nvim",
    init = function()
      vim.cmd("autocmd User LspProgressUpdate let &ro = &ro")
    end,
    opts = function()
      local present, lsp_status = pcall(require, "lsp-status")
      local function clock()
        return " " .. os.date("%H:%M")
      end

      local function lsp_progress()
        if present and vim.lsp.buf_get_clients() > 0 then
          lsp_status.status()
        end
      end
      return {
        options = {
          theme = "tokyonight",
          icons_enabled = true,
          -- section_separators = {"", ""},
          -- component_separators = {"", ""}
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "diagnostics", sources = { "nvim_diagnostic" } }, { "filename", path = 1 } },
          lualine_x = { "filetype", lsp_progress },
          lualine_y = { "diff" },
          lualine_z = { clock },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
        },
      }
    end,
  },
}
