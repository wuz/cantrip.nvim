return {
  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require("tabout").setup {
        tabkey = "<Tab>",             -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true,            -- shift content if tab out is not possible
        act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>",        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>",  -- reverse shift default action,
        enable_backwards = true,      -- well ...
        completion = false,           -- if the tabkey is used in a completion pum
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
      }
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
    },
    opt = true,              -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
  -- Make more things repeatable
  { "tpope/vim-repeat" },
  -- highlight selected range from commandline
  {
    "winston0410/range-highlight.nvim",
    dependencies = { "winston0410/cmd-parser.nvim" },
  },
  -- better scrolling
  -- Disable relative numbers when they don't make sense
  {
    "nkakouros-original/numbers.nvim",
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
            ["|(%S-)|"] = vim.cmd.help,                       -- vim help links
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
          bottom_search = true,          -- use a classic bottom cmdline for search
          command_palette = false,       -- position the cmdline and popupmenu together
          long_message_to_split = false, -- long messages will be sent to a split
          inc_rename = false,            -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true,         -- add a border to hover docs and signature help
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
      require("modicator").setup {
        show_warnings = false,
        highlights = {
          defaults = { bold = true },
        },
      }
    end,
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
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     disabled_keys = {
  --       ["<Up>"] = { "", "n" },
  --       ["<Down>"] = { "", "n" },
  --       ["<Left>"] = { "", "n" },
  --       ["<Right>"] = { "", "n" },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("hardtime").setup(opts)
  --   end,
  -- },
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   vscode = true,
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- },
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
  -- {
  --   "ellisonleao/carbon-now.nvim",
  --   opts = {
  --     open_cmd = "open",
  --   },
  --   cmd = "CarbonNow",
  -- },
  -- Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoLocList", "TodoTelescope", "TodoQuickFix" },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
    },
    opts = {
      gui_style = {
        fg = "NONE",                         -- The gui style to use for the fg highlight group.
        bg = "BOLD",                         -- The gui style to use for the bg highlight group.
      },
      pattern = [[\b(KEYWORDS)(\(\w*\))?:]], -- ripgrep regex
    },
    config = true,
  },
  -- / Comments
  -- Toggle between values
  {
    "nguyenvukhang/nvim-toggler",
    config = true,
  },
  { "onsails/lspkind-nvim" },
  -- -- extra lsp tools
  { "tami5/lspsaga.nvim",            dependencies = "nvim-lspconfig" },
  { "nvim-lua/lsp-status.nvim",      dependencies = "nvim-lspconfig" },
  { "ray-x/lsp_signature.nvim",      dependencies = "nvim-lspconfig" },
  { "simrat39/symbols-outline.nvim", dependencies = "nvim-lspconfig" },
  -- -- lsp-based formatters
}
