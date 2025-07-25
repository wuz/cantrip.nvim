local Cantrip = require("cantrip.utils")

--@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
  -- Plugin manager
  { "folke/lazy.nvim", version = false },
  -- Load cantrip as a plugin
  {
    "wuz/cantrip.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    config = true,
  },
  -- Lua utils
  { "nvim-lua/plenary.nvim" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "cantrip.nvim", words = { "Cantrip" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  -- UI Utilities
  { "MunifTanjim/nui.nvim" },
  -- Smoother scrolling
  { "karb94/neoscroll.nvim", config = true },
  { "nvimtools/hydra.nvim" },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      ---@class snacks.dashboard.Config
      ---@field enabled? boolean
      ---@field sections snacks.dashboard.Section
      ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
      dashboard = {
        preset = {
          -- stylua: ignore
          header = [[
       .―――――.                       ╔╦╦╦╦╗
   .―――│_   _│           .―.         ║~~~~║
.――│===│― C ―│_          │_│     .――.║~~~~║
│  │===│  A  │'⧹     ┌―――┤~│  ┌――│∰ │╢    ║
│%%│ ⟐ │  N  │.'⧹    │===│ │――│%%│  │║    ║
│%%│ ⟐ │  T  │⧹.'⧹   │⦑⦒ │ │__│  │  │║ ⧊  ║
│  │ ⟐ │  R  │ ⧹.'⧹  │===│ │==│  │  │║    ║
│  │ ⟐ │_ I _│  ⧹.'⧹ │ ⦑⦒│_│__│  │∰ │║~~~~║
│  │===│― P ―│   ⧹.'⧹│===│~│――│%%│――│║~~~~║
╰――╯―――'―――――╯    `―'`―――╯―^――^――^――'╚╩╩╩╩╝
          ⁂ neovim + dark magic ⁂        ]],
        },
      },
    },
  },
  {
    -- Log timing of editor startup
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = require("cantrip.config.which_key"),
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show { global = false }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "mvllow/modes.nvim",
    tag = "v0.2.1",
    config = true,
  },
  -- Colorscheme
  { "rktjmp/lush.nvim" },
  -- Configurable highlight patterns
  {
    "echasnovski/mini.hipatterns",
    version = "*",
    opts = require("cantrip.config.hipatterns"),
  },
  -- Better a/i textobjects
  { "echasnovski/mini.ai", version = false },
  -- Better ui.select and ui.input
  { "stevearc/dressing.nvim" },
  -- mini.icons with nvim web devicon mocking
  {
    "echasnovski/mini.icons",
    version = false,
    config = require("cantrip.config.icons"),
  },
  -- Highlight line indents
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
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    init = function()
      vim.g.navic_silence = true
      Cantrip.lsp.on_attach(function(client, buffer)
        if client:supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = require("cantrip.config.treesitter").opts,
    init = require("cantrip.config.treesitter").init,
    config = require("cantrip.config.treesitter").config,
  },
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter" },
    lazy = true,
    config = true,
  },
  { "nvim-treesitter/nvim-treesitter-refactor", dependencies = { "nvim-treesitter" }, lazy = true },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter" }, lazy = true },
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  -- Highlight trailing spaces
  { "echasnovski/mini.trailspace", version = false, config = true },
  -- Improve deleting buffers
  {
    "echasnovski/mini.bufremove",
    version = false,
    keys = {
      {
        "<Leader>bc",
        function()
          require("mini.bufremove").delete(0)
        end,
        desc = "Close buffer",
      },
    },
    config = true,
  },
  -- Simple tabline for viewing open buffers
  {
    "echasnovski/mini.tabline",
    version = false,
    config = true,
    lazy = true,
    keys = {
      { "<M-h>", "<cmd>bprev<cr>", desc = "Prev buffer" },
      { "<M-l>", "<cmd>bnext<cr>", desc = "Next buffer" },
      { "[b", "<cmd>bprev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>bnext<cr>", desc = "Next buffer" },
    },
  },

  -- Surround code
  {
    "echasnovski/mini.surround",
    version = false,
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
    config = true,
  },
  -- Align code
  { "echasnovski/mini.align", version = false, config = true },

  {
    "folke/which-key.nvim",
    optional = true,
    opts_extend = { "spec" },
    opts = {
      ---@type wk.Spec
      spec = {
        { "<leader>h", name = "+harpoon" },
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    keys = function()
      local harpoon = require("harpoon")
      return {
        {
          "<leader>ha",
          function()
            harpoon:list():add()
          end,
          desc = "Add file to harpoon list",
        },
        {
          "<leader>hr",
          function()
            harpoon:list():remove()
          end,
          desc = "Remove file from harpoon list",
        },
        {
          "<leader>ht",
          function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "",
        },
        {
          "<leader>h1",
          function()
            harpoon:list():select(1)
          end,
        },
        {
          "<leader>h2",
          function()
            harpoon:list():select(2)
          end,
        },
        {
          "<leader>h3",
          function()
            harpoon:list():select(3)
          end,
        },
        {
          "<leader>h4",
          function()
            harpoon:list():select(4)
          end,
        },

        -- Toggle previous & next buffers stored within Harpoon list
        {
          "[h",
          function()
            harpoon:list():prev()
          end,
        },
        {
          "]h",
          function()
            harpoon:list():next()
          end,
        },
      }
    end,
    opts = {},
    config = function(_, opts)
      local harpoon = require("harpoon")
      harpoon:setup(opts)
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "echasnovski/mini.icons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd({ "BufLeave" }, {
        callback = function()
          local num_windows = vim.fn.winnr("$")
          if num_windows == 1 and vim.bo.filetype == "Trouble" then
            require("trouble").close()
          end
        end,
      })
    end,
    opts = {
      modes = {
        diagnostics = {},
        lsp = {
          win = { position = "right" },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    keys = function()
      local neotest = require("neotest")
      ---@type LazyKeys[]
      return {
        {
          "<leader>tf",
          function()
            neotest.run.run { strategy = "dap" }
          end,
          desc = "Test File (DAP)",
        },
      }
    end,
  },
  -- fancy UI for the debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
    },
    opts = {},
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    event = "BufRead",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
      },
      -- which key integration
      {
        "folke/which-key.nvim",
        optional = true,
        opts_extend = { "spec" },
        opts = {
          spec = {
            { "<leader>d", group = "debug" },
          },
        },
      },
      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          automatic_installation = true,
          handlers = {},
          ensure_installed = {},
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },
    opts = {
      {
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
              "scopes",
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 10,
            position = "bottom",
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
      },
    },
    config = function(_, opts)
      -- Temp fix for bug in setting filetype
      -- https://github.com/rcarriga/nvim-dap-ui/issues/219#issuecomment-1413427313
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      vim.schedule(function()
        require("dapui").setup(opts)
      end)
    end,
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    keys = {
      {
        "<leader>qr",
        function()
          require("quicker").toggle()
        end,
        desc = "run replacer.nvim",
      },
    },
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      keys = {
        {
          ">",
          function()
            require("quicker").expand { before = 2, after = 2, add_to_existing = true }
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    },
  },
  {
    "Wansmer/sibling-swap.nvim",
    dependencies = { "nvim-treesitter" },
  },

  -- Supercharge w, e, b text motions
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    dependencies = {
      "theHamsta/nvim_rocks",
      build = "pip3 install --user hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
      config = function()
        require("nvim_rocks").ensure_installed("luautf8")
      end,
    },
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
      -- ...
    },
  },

  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      {
        "n",
        function()
          vim.cmd("execute('normal! ' . v:count1 . 'n')")
          require("hlslens").start()
        end,
      },
      {
        "N",
        function()
          vim.cmd("execute('normal! ' . v:count1 . 'N')")
          require("hlslens").start()
        end,
      },
      {
        "*",
        function()
          vim.cmd("*")
          require("hlslens").start()
        end,
      },
      {
        "#",
        function()
          vim.cmd("#")
          require("hlslens").start()
        end,
      },
      {
        "g*",
        function()
          vim.cmd("g*")
          require("hlslens").start()
        end,
      },
      {
        "g#",
        function()
          vim.cmd("g#")
          require("hlslens").start()
        end,
      },
      {
        "<leader>l",
        "<Cmd>noh<cr>",
      },
    },
    opts = {},
    config = true,
  },

  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
    },
    opts = function()
      return {
        excluded_filetypes = {
          "prompt",
          "snacks_dashboard",
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
    "ggandor/flit.nvim",
    enabled = true,
    keys = function()
      local ret = {}
      for _, key in ipairs { "f", "F", "t", "T" } do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "echasnovski/mini.icons" },
    keys = {
      {
        "<leader>xx",
        function()
          require("trouble").toggle()
        end,
      },
      {
        "<leader>xd",
        function()
          require("trouble").toggle("diagnostics")
        end,
      },
      {
        "<leader>xq",
        function()
          require("trouble").toggle("quickfix")
        end,
      },
      {
        "<leader>xl",
        function()
          require("trouble").toggle("loclist")
        end,
      },
      {
        "gR",
        function()
          require("trouble").toggle("lsp_references")
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd({ "BufLeave" }, {
        callback = function()
          local num_windows = vim.fn.winnr("$")
          if num_windows == 1 and vim.bo.filetype == "Trouble" then
            require("trouble").close()
          end
        end,
      })
    end,
    opts = {
      modes = {
        diagnostics = {},
      },
    },
  },

  -- {
  --   "echasnovski/mini.pairs",
  --   event = "VeryLazy",
  --   opts = {
  --     ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%a\\].", register = { cr = false } },
  --     ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%a\\].", register = { cr = false } },
  --   },
  --   config = function(_, opts)
  --     require("mini.pairs").setup(opts)
  --   end,
  -- },

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
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      pattern = [[\b(KEYWORDS)(\(\w*\))?:]], -- ripgrep regex
    },
    config = true,
  },

  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require("tabout").setup {
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
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
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
  -- ====== UTIL ====== --
  -- highlight selected range from commandline
  {
    "winston0410/range-highlight.nvim",
    dependencies = { "winston0410/cmd-parser.nvim" },
  },
  -- Search for nvim plugins
  {
    "alex-popov-tech/store.nvim",
    dependencies = {
      "OXY2DEV/markview.nvim", -- optional, for pretty readme preview / help window
    },
    cmd = "Store",
    keys = {
      { "<leader>s", "<cmd>Store<cr>", desc = "Open Plugin Store" },
    },
    opts = {
      -- optional configuration here
    },
  },
}
