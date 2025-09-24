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
  { "folke/lazy.nvim",      version = false },
  -- Load cantrip as a plugin
  {
    "wuz/cantrip.nvim",
    lazy = false,     -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    config = true,
  },
  -- Lua utils
  { "nvim-lua/plenary.nvim" },
  { "tpope/vim-repeat",     event = "VeryLazy" },
  -- UI Utilities
  { "MunifTanjim/nui.nvim" },
  { "nvimtools/hydra.nvim" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {},
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      if Cantrip.has("noice.nvim") then
        vim.notify = notify
      end
    end,
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      input = { enabled = true },
      ---@class snacks.dashboard.Config
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
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- Move any selection in any direction
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<C-h>",
        right = "<C-l>",
        down = "<C-j>",
        up = "<C-k>",

        -- Move current line in Normal mode
        line_left = "<C-h>",
        line_right = "<C-l>",
        line_down = "<C-j>",
        line_up = "<C-k>",
      },
    },
  },
  -- Diff
  {
    "echasnovski/mini.diff",
    event = "VeryLazy",
    keys = {
      {
        "<leader>go",
        function()
          require("mini.diff").toggle_overlay(0)
        end,
        desc = "Toggle mini.diff overlay",
      },
    },
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "",
        },
      },
    },
  },
  -- Configurable highlight patterns
  {
    "echasnovski/mini.hipatterns",
    version = "*",
    opts = require("cantrip.config.hipatterns"),
  },
  -- Better a/i textobjects
  { "echasnovski/mini.ai",   version = false },
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
    "nvimdev/indentmini.nvim",
    event = "BufEnter",
    opts = {},
    config = true,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      icons = Cantrip.icons.ui.kind_icons,
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
  { "nvim-treesitter/nvim-treesitter-refactor",    dependencies = { "nvim-treesitter" }, lazy = true },
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
      { "[b",    "<cmd>bprev<cr>", desc = "Prev buffer" },
      { "]b",    "<cmd>bnext<cr>", desc = "Next buffer" },
    },
  },

  -- Surround code
  {
    "echasnovski/mini.surround",
    version = false,
    opts = {
      mappings = {
        add = "sa",            -- Add surrounding in Normal and Visual modes
        delete = "sd",         -- Delete surrounding
        find = "sf",           -- Find surrounding (to the right)
        find_left = "sF",      -- Find surrounding (to the left)
        highlight = "sh",      -- Highlight surrounding
        replace = "sr",        -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
    config = true,
  },
  -- Align code
  { "echasnovski/mini.align",      version = false, config = true },

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
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "trouble: Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "trouble: Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "trouble: Symbols" },
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle<cr>",
        desc = "trouble: LSP references/definitions/...",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "trouble: Location List" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",  desc = "trouble: Quickfix List" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
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
            require("trouble").next({ skip_groups = true, jump = true })
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
        diagnostics = {
          win = { position = "right" },
        },
        lsp = {
          win = { position = "right" },
        },
      },
    },
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
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
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
    lazy = true,
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
      for _, key in ipairs({ "f", "F", "t", "T" }) do
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
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
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

  -- {
  --   "echasnovski/mini.pairs",
  --   event = "VeryLazy",
  --   opts = {
  --     ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%a\\].", register = { cr = false } },
  --     ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%a\\].", register = { cr = false } },
  --     modes = { insert = true, command = true, terminal = false },
  --     -- skip autopair when next character is one of these
  --     skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  --     -- skip autopair when the cursor is inside these treesitter nodes
  --     skip_ts = { "string" },
  --     -- skip autopair when next character is closing pair
  --     -- and there are more closing pairs than opening pairs
  --     skip_unbalanced = true,
  --     -- better deal with markdown code blocks
  --     markdown = true,
  --   },
  --   config = function(_, opts)
  --     local pairs = require("mini.pairs")
  --     pairs.setup(opts)
  --     local open = pairs.open
  --     pairs.open = function(pair, neigh_pattern)
  --       if vim.fn.getcmdline() ~= "" then
  --         return open(pair, neigh_pattern)
  --       end
  --       local o, c = pair:sub(1, 1), pair:sub(2, 2)
  --       local line = vim.api.nvim_get_current_line()
  --       local cursor = vim.api.nvim_win_get_cursor(0)
  --       local next = line:sub(cursor[2] + 1, cursor[2] + 1)
  --       local before = line:sub(1, cursor[2])
  --       if opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
  --         return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
  --       end
  --       if opts.skip_next and next ~= "" and next:match(opts.skip_next) then
  --         return o
  --       end
  --       if opts.skip_ts and #opts.skip_ts > 0 then
  --         local ok, captures = pcall(vim.treesitter.get_captures_at_pos, 0, cursor[1] - 1, math.max(cursor[2] - 1, 0))
  --         for _, capture in ipairs(ok and captures or {}) do
  --           if vim.tbl_contains(opts.skip_ts, capture.capture) then
  --             return o
  --           end
  --         end
  --       end
  --       if opts.skip_unbalanced and next == c and c ~= o then
  --         local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
  --         local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
  --         if count_close > count_open then
  --           return o
  --         end
  --       end
  --       return open(pair, neigh_pattern)
  --     end
  --   end,
  -- },

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
        fg = "NONE",                         -- The gui style to use for the fg highlight group.
        bg = "BOLD",                         -- The gui style to use for the bg highlight group.
      },
      pattern = [[\b(KEYWORDS)(\(\w*\))?:]], -- ripgrep regex
    },
    config = true,
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
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
    end,
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    keys = {
      { "<leader>,", "<cmd>ClaudeCode<cr>", desc = "Open Claude Code" },
    },
    config = function()
      require("claude-code").setup()
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      ---@type lazydev.Library.spec[]
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "cantrip.nvim",       words = { "Cantrip" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
        { path = "lazydev.nvim",       words = { "lazydev" } },
        { path = "lazy.nvim",          words = { "Cantrip" } },
      },
    },
  },
}
