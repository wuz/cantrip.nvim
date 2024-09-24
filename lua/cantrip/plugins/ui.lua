return {
  -- Better icons in nvim
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      MiniIcons = require("mini.icons")
      MiniIcons.setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
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
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<Down>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<Down>"
          end
        end,
        { silent = true, expr = true },
      },

      {
        "<Up>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<Up>"
          end
        end,
        { silent = true, expr = true },
      },
    },
    opts = function()
      return {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = {
            enabled = true,
            silent = true,
          },
          signature = {
            enabled = true,
          },
          documentation = {
            view = "hover",
            opts = {
              lang = "markdown",
              replace = false,
              render = "plain",
              format = { "{message}" },
              win_options = { concealcursor = "n", conceallevel = 3 },
            },
          },
        },
        markdown = {
          hover = {
            ["|(%S-)|"] = vim.cmd.help, -- vim help links
            ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
          },
          highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
          },
        },
        routes = {
          {
            filter = {
              event = "notify",
              find = "No information available",
            },
            opts = { skip = true },
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = false, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        cmdline = {
          enabled = false,
        },
        messages = {
          enabled = false,
        },
        views = {
          hover = {
            border = {
              style = "rounded",
            },
            view = "popup",
            relative = "cursor",
            zindex = 45,
            enter = false,
            anchor = "auto",
            size = {
              width = "auto",
              height = "auto",
              max_width = 120,
            },
            position = { row = 2, col = 2 },
            win_options = {
              wrap = true,
              linebreak = true,
            },
          },
        },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  -- Indent highlight groups
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = {
        char = "│",
      },
    },
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
    dependencies = {
      "SmiteshP/nvim-navic",
    },
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
        local lsp_status = require("lsp-status")
        local navic = require("nvim-navic")
        local devicons = require("nvim-web-devicons")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local res = {}
        table.insert(res, {
          { " [ ", group = "NavicSeparator" },
          { lsp_status.status() },
          { " ] ", group = "NavicSeparator" },
        })
        table.insert(res, {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          guibg = "#44406e",
        })
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
