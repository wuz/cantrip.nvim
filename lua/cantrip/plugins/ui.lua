return {
  { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
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
      require("modicator").setup({
        show_warnings = false,
        highlights = {
          defaults = { bold = true },
        },
      })
    end,
  },
  {
    "echasnovski/mini.bufremove",
    version = false,
    config = function()
      require("mini.cursorword").setup()
    end,
  },
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
  { "sunjon/shade.nvim" },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>fc", ":Twilight", desc = "Focus Code" },
    },
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
        offsets = { { filetype = "neo-tree", text = "", padding = 1 } },
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
        diagnostics = "nvim_lsp",
      },
    },
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
    event = "VeryLazy",
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
    main = "ibl",
    config = function(_, opts)
      vim.cmd([[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]])

      vim.opt.list = true
      vim.opt.listchars:append("eol:↴")

      require("ibl").setup(opts)
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
  --   {
  --     "hoob3rt/lualine.nvim",
  --     init = function()
  --       vim.cmd("autocmd User LspProgressUpdate let &ro = &ro")
  --     end,
  --     opts = function()
  --       local present, lsp_status = pcall(require, "lsp-status")
  --       local function clock()
  --         return " " .. os.date("%H:%M")
  --       end
  --
  --       local function lsp_progress()
  --         if present and vim.lsp.get_active_clients() > 0 then
  --           lsp_status.status()
  --         end
  --       end
  --       return {
  --         options = {
  --           theme = "tokyonight",
  --           icons_enabled = true,
  --           -- section_separators = {"", ""},
  --           -- component_separators = {"", ""}
  --           component_separators = { left = "", right = "" },
  --           section_separators = { left = "", right = "" },
  --         },
  --         sections = {
  --           lualine_a = { "mode" },
  --           lualine_b = { "branch", "diff" },
  --           lualine_c = { { "diagnostics", sources = { "nvim_diagnostic" } }, { "filename", path = 1 } },
  --           lualine_x = { "filetype", lsp_progress },
  --           lualine_y = { "diff" },
  --           lualine_z = { clock },
  --         },
  --         inactive_sections = {
  --           lualine_a = {},
  --           lualine_b = {},
  --           lualine_c = {},
  --           lualine_x = {},
  --           lualine_y = {},
  --         },
  --       }
  --     end,
  --   },
  -- {
  --   "lukas-reineke/virt-column.nvim",
  --   config = true,
  -- },
}
