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
  { "folke/lazy.nvim", version = "*" },
  -- Load cantrip as a plugin
  {
    "wuz/cantrip.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    config = true,
  },
  -- Disable relative numbers when they don't make sense
  { "nkakouros-original/numbers.nvim", config = true },
  -- Make more things repeatable
  { "tpope/vim-repeat" },
  -- Lua utils
  { "nvim-lua/plenary.nvim" },
  -- UI Utilities
  { "MunifTanjim/nui.nvim" },
  -- Smoother scrolling
  { "karb94/neoscroll.nvim", config = true },
  { "nvimtools/hydra.nvim" },
  -- {
  --   "goolord/alpha-nvim",
  --   dependencies = { "echasnovski/mini.icons", "ThePrimeagen/harpoon", "nvim-telescope/telescope.nvim" },
  --   opts = function()
  --     local harpoon = require("harpoon")
  --     local dashboard = require("alpha.themes.dashboard")
  --     local conf = require("telescope.config").values
  --     local function button(sc, txt, keybind)
  --       local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")
  --
  --       local opts = {
  --         position = "center",
  --         text = txt,
  --         shortcut = sc,
  --         cursor = 5,
  --         width = 36,
  --         align_shortcut = "right",
  --         hl = "AlphaButtons",
  --       }
  --
  --       if keybind then
  --         opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  --       end
  --
  --       return {
  --         type = "button",
  --         val = txt,
  --         on_press = function()
  --           local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
  --           vim.api.nvim_feedkeys(key, "normal", false)
  --         end,
  --         opts = opts,
  --       }
  --     end
  --
  --     local function toggle_telescope(harpoon_files)
  --       local file_paths = {}
  --       for _, item in ipairs(harpoon_files.items) do
  --         table.insert(file_paths, item.value)
  --       end
  --
  --       require("telescope.pickers")
  --         .new({}, {
  --           prompt_title = "Harpoon",
  --           finder = require("telescope.finders").new_table {
  --             results = file_paths,
  --           },
  --           previewer = conf.file_previewer {},
  --           sorter = conf.generic_sorter {},
  --         })
  --         :find()
  --     end
  --
  --
  --     dashboard.section.buttons.val = {
  --       button("h", "󰛢  Harpooned  ", function()
  --         toggle_telescope(harpoon:list())
  --       end),
  --       button("<space>", "  Find File  ", ":Telescope smart_open<CR>"),
  --       button("m", "  Recent File  ", ":Telescope oldfiles<CR>"),
  --       button("n", "  New file  ", ":ene <BAR> startinsert <CR>"),
  --       button("a", "  Find Word  ", ":Telescope live_grep<CR>"),
  --     }
  --     dashboard.section.footer.opts.hl = "Type"
  --     dashboard.section.header.opts.hl = "AlphaHeader"
  --     dashboard.section.buttons.opts.hl = "AlphaButtons"
  --     dashboard.opts.layout[1].val = 8
  --     return dashboard
  --   end,
  --   config = function(_, dashboard)
  --     require("alpha").setup(dashboard.opts)
  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "LazyVimStarted",
  --       callback = function()
  --         local stats = require("lazy").stats()
  --         local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --         dashboard.section.footer.val = "cantrip loaded " .. stats.count .. " plugins in " .. ms .. "ms"
  --         pcall(vim.cmd.AlphaRedraw)
  --       end,
  --     })
  --   end,
  -- },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
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
  -- Colorscheme
  { "rktjmp/lush.nvim" },
  -- Configurable highlight patterns
  {
    "echasnovski/mini.hipatterns",
    version = "*",
    opts = require("cantrip.config.hipatterns"),
  },
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
    "mcauley-penney/visual-whitespace.nvim",
    config = true,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    init = function()
      vim.g.navic_silence = true
      Cantrip.lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    config = true,
  },
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
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "VeryLazy" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = require("cantrip.config.treesitter").opts,
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
      require("lazy.core.loader").add_to_rtp(plugin)
      pcall(require, "nvim-treesitter.query_predicates")
    end,
    config = require("cantrip.config.treesitter").config,
  },
  { "nvim-treesitter/nvim-treesitter-refactor", dependencies = { "nvim-treesitter" }, lazy = true },
  { "JoosepAlviste/nvim-ts-context-commentstring", dependencies = { "nvim-treesitter" }, lazy = true },
  { "RRethy/nvim-treesitter-textsubjects", dependencies = { "nvim-treesitter" }, lazy = true },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter" }, lazy = true },

  -- Highlight trailing spaces
  { "echasnovski/mini.trailspace", version = false, config = true },
  -- Improve deleting buffers
  { "echasnovski/mini.bufremove", version = false, config = true },
  -- Toggle comments
  { "echasnovski/mini.comment", version = false, config = true },
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
        add = "Za", -- Add surrounding in Normal and Visual modes
        delete = "Zd", -- Delete surrounding
        find = "Zf", -- Find surrounding (to the right)
        find_left = "ZF", -- Find surrounding (to the left)
        highlight = "Zh", -- Highlight surrounding
        replace = "Zr", -- Replace surrounding
        update_n_lines = "Zn", -- Update `n_lines`
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

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "olimorris/neotest-rspec",
      "haydenmeade/neotest-jest",
      "nvim-neotest/neotest-vim-test",
      "marilari88/neotest-vitest",
    },
    keys = function()
      local neotest = require("neotest")
      ---@type LazyKeys[]
      local ret = {}
      ret[#ret + 1] = {
        "<leader>tn",
        function()
          neotest.run.run {
            vim.fn.expand("%"),
            vitestCommand = "npm run vitest --watch",
          }
        end,
        desc = "Test File",
      }
      ret[#ret + 1] = {
        "<leader>tf",
        function()
          neotest.run.run { strategy = "dap" }
        end,
        desc = "Test File (DAP)",
      }
      return ret
    end,
    opts = function()
      return {
        adapters = {
          ["neotest-vitest"] = {},
          ["neotest-jest"] = {},
          ["neotest-rspec"] = {},
          ["neotest-vim-test"] = {
            ignore_filetypes = { "python", "javascript", "typescript" },
          },
        },
      }
    end,
  },
  -- fancy UI for the debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
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
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
      }
      local dap = require("dap")
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
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
    "gabrielpoca/replacer.nvim",
    lazy = true,
    keys = {
      {
        "<leader>qrr",
        function()
          require("replacer").run()
        end,
        desc = "run replacer.nvim",
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
    "petertriho/nvim-scrollbar",
    opts = function()
      return {
        excluded_filetypes = {
          "prompt",
          "noice",
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

  -- show lightbulb when line has code actions
  {
    "kosayoda/nvim-lightbulb",
    init = function()
      vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
    end,
    opt = {
      sign = {
        enabled = true,
      },
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
  -- highlight selected range from commandline
  {
    "winston0410/range-highlight.nvim",
    dependencies = { "winston0410/cmd-parser.nvim" },
  },
}
