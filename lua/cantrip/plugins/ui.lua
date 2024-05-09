return {
  -- Better icons in nvim
  { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
  -- Inline annotation adding context to tags/brackes/parens/etc
  {
    "code-biscuits/nvim-biscuits",
    opts = {
      show_on_start = true,
      cursor_line_only = true,
      default_config = {
        prefix_string = "» ",
      },
    },
    config = function(_, opts)
      vim.cmd([[highlight! link BiscuitColor Comment]])
      require("nvim-biscuits").setup(opts)
    end,
    dependencies = {
      "nvim-treesitter",
    },
  },
  -- Better ui.select and ui.input
  {
    "stevearc/dressing.nvim",
  },
  -- Indent highlight groups
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
  -- Dim inactive panes
  { "sunjon/shade.nvim" },
  -- highlight the word under the cursor
  {
    "echasnovski/mini.cursorword",
    version = false,
    config = true,
  },
  -- Focus sections of code, with treesitter
  {
    "folke/twilight.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>fc", ":Twilight", desc = "Focus Code" },
    },
  },
  -- highlight matched information
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
  -- change colors based on current vim mode
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
  -- Build custom UIs
  {
    "anuvyklack/hydra.nvim",
  },
  -- show lightbulb when line has code actions
  {
    "kosayoda/nvim-lightbulb",
    init = function()
      vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
    end,
    opt = {
      ignore = { "null-ls" },
      sign = {
        enabled = true,
      },
    },
  },
  -- Floating statusbars
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        placement = {
          vertical = "bottom",
          horizontal = "center",
        },
        padding = 0,
        margin = { vertical = 0, horizontal = 0 },
      },
      hide = {
        cursorline = true,
      },
      render = function(props)
        local helpers = require("incline.helpers")
        local navic = require("nvim-navic")
        local devicons = require("nvim-web-devicons")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local res = {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          guibg = "#44406e",
        }
        if props.focused then
          for _, item in ipairs(navic.get_data(props.buf) or {}) do
            table.insert(res, {
              { " > ", group = "NavicSeparator" },
              { item.icon, group = "NavicIcons" .. item.type },
              { item.name, group = "NavicText" },
            })
          end
        end
        table.insert(res, " ")
        return res
      end,
    },
    config = true,
  },
}
