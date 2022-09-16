local present, packer = pcall(require, "packerinit")
if not present then
  return false
end

return require("packer").startup({
  function()
    -- --------------
    -- === BUILTINS
    -- --------------
    use({ "lewis6991/impatient.nvim" })
    use({ "wbthomason/packer.nvim", event = "VimEnter" })
    use({ "nvim-lua/plenary.nvim" })
    use({ "Iron-E/nvim-cartographer" })
    use({
      "nathom/filetype.nvim",
      config = function()
        vim.g.did_load_filetypes = 1
      end,
    })
    --use({ "antoinemadec/FixCursorHold.nvim" })
    use({ "nvim-lua/popup.nvim", requries = "nvim-lua/plenary.nvim" })
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("config.notify")
      end,
    })
    use({
      "chentoast/marks.nvim",
      config = function()
        require("config.other").marks()
      end,
    })
    use({ "famiu/bufdelete.nvim" })
    use({ "akinsho/toggleterm.nvim", event = "BufEnter" })
    use({
      "beauwilliams/focus.nvim",
      config = function()
        require("config.focus").setup()
      end,
    })

    -- == Motion
    -- ----------------
    use({
      "unblevable/quick-scope",
      config = function()
        require("config.other").quickscope()
      end,
    })

    -- == Debugging
    -- ----------------
    use({
      "rcarriga/nvim-dap-ui",
      event = "BufRead",
      requires = { "mfussenegger/nvim-dap", "Pocco81/DAPInstall.nvim" },
      config = function()
        require("config.other").dap()
      end,
    })

    -- == Testing
    -- ----------------
    use({
      "nvim-neotest/neotest",
      requires = {
        "olimorris/neotest-rspec",
        "haydenmeade/neotest-jest",
        "nvim-neotest/neotest-vim-test",
      },
      config = function()
        require("config.other").test()
      end,
    })

    -- == TODOs
    -- ----------------
    use({
      "folke/todo-comments.nvim",
      cmd = { "TodoTrouble", "TodoLocList", "TodoTelescope", "TodoQuickFix" },
      config = function()
        require("config.other").todo()
      end,
    })

    -- == Code Actions
    -- ----------------=
    use({
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
    })

    -- == Treesitter
    -- ----------------
    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("config.autopairs")
      end,
    })
    use({
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("config.treesitter")
      end,
    })
    use({ "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" })
    use({ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" })
    use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
    use({
      "abecodes/tabout.nvim",
      config = function()
        require("config.other").tabout()
      end,
      wants = { "nvim-treesitter" },
      after = { "nvim-cmp" },
    })

    -- for all syntax not supported by treesitter
    use({
      "sheerun/vim-polyglot",
      setup = function()
        require("config.polyglot")
      end,
    })
    use({
      "styled-components/vim-styled-components",
      ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    })
    use({ "ellisonleao/glow.nvim", ft = "markdown" })

    -- == Comments
    -- ----------------
    use({
      "numToStr/Comment.nvim",
      after = "nvim-ts-context-commentstring",
      config = function()
        require("config.other").comment()
      end,
    })

    -- == Completion
    -- ----------------
    use({
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
    })
    use({ "L3MON4D3/LuaSnip", after = "friendly-snippets" })
    use({
      "hrsh7th/nvim-cmp",
      after = "LuaSnip",
      config = function()
        require("config.completion")
      end,
    })
    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
    use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })
    use({ "quangnguyen30192/cmp-nvim-tags", after = "nvim-cmp" })
    use({ "lukas-reineke/cmp-rg", after = "nvim-cmp" })
    use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })

    -- == Surround
    -- ----------------
    use({
      "ur4ltz/surround.nvim",
      config = function()
        require("surround").setup({ mappings_style = "sandwich" })
      end,
    })

    -- == LSP
    -- ----------------
    use({ "neovim/nvim-lspconfig", event = "BufEnter" })
    use({ "tami5/lspsaga.nvim", after = "nvim-lspconfig" })
    use({ "nvim-lua/lsp-status.nvim", after = "nvim-lspconfig" })
    use({ "ray-x/lsp_signature.nvim", after = "nvim-lspconfig" })
    use({ "onsails/lspkind-nvim", after = "nvim-lspconfig" })
    use({ "simrat39/symbols-outline.nvim", after = "nvim-lspconfig" })
    -- Even better lua dev
    use({ "folke/lua-dev.nvim", ft = "lua", after = "nvim-lspconfig" })
    use({ "williamboman/mason-lspconfig.nvim", after = "nvim-lspconfig" })
    use({
      "williamboman/mason.nvim",
      after = {
        "nvim-lspconfig",
        "mason-lspconfig.nvim",
        "lspsaga.nvim",
        "lsp-status.nvim",
        "lsp_signature.nvim",
        "lspkind-nvim",
        "cmp-nvim-lsp",
        "symbols-outline.nvim",
        "lua-dev.nvim",
      },
      config = function()
        require("config.lsp")
      end,
    })
    use({
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("config.format")
      end,
    })
    use({
      "kosayoda/nvim-lightbulb",
      config = function()
        require("config.lightbulb")
      end,
    })
    use({
      "junegunn/vim-easy-align",
      config = function()
        require("config.easy_align")
      end,
    })
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("config.other").fidget()
      end,
    })
    -- use({ "Maan2003/lsp_lines.nvim", after = "nvim-lspconfig" })

    -- ----------------
    -- === APPEARANCE
    -- ----------------

    -- == Colors
    -- ----------------
    use({ "rktjmp/lush.nvim" })
    use({ "folke/tokyonight.nvim" })
    use({ "folke/lsp-colors.nvim" })

    -- == Icons
    -- ----------------
    use({
      "kyazdani42/nvim-web-devicons",
      event = "BufEnter",
      config = function()
        require("config.other").icons()
      end,
    })

    -- == Highlight/Focus
    -- --------------------
    use({
      "sunjon/Shade.nvim",
      config = function()
        require("shade").setup()
      end,
    })
    use({
      "folke/twilight.nvim",
      cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
      config = function()
        require("config.twilight")
      end,
    })
    use({
      "kyazdani42/nvim-tree.lua",
      cmd = {
        "NvimTreeOpen",
        "NvimTreeFocus",
        "NvimTreeToggle",
      },
      keys = { "<Leader>/" },
      after = "nvim-web-devicons",
      config = function()
        require("config.tree")
      end,
    })

    -- == Quickfix/Loclist
    -- --------------------
    use({
      "folke/trouble.nvim",
      after = "nvim-web-devicons",
      config = function()
        require("config.trouble")
      end,
    })

    -- == Bufferline Tabs
    -- --------------------
    use({
      "akinsho/bufferline.nvim",
      after = "nvim-web-devicons",
      config = function()
        require("config.bufferline")
      end,
    })

    -- == File Finder
    -- ----------------
    use({
      "nvim-telescope/telescope.nvim",
      after = "trouble.nvim",
      config = function()
        require("config.telescope")
      end,
      requires = {
        "nvim-telescope/telescope-packer.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope-github.nvim",
      },
    })

    -- == Dashboard / Startup
    -- ------------------------
    use({
      "goolord/alpha-nvim",
      after = "nvim-web-devicons",
      config = function()
        require("config.alpha")
      end,
    })

    -- == Statusline
    -- ---------------
    use({
      "hoob3rt/lualine.nvim",
      config = function()
        require("config.statusline")
      end,
      after = { "nvim-web-devicons", "lsp-status.nvim" },
    })

    -- == Gutter/Numbers
    -- -------------------
    use({
      "nacro90/numb.nvim",
      config = function()
        require("numb").setup()
      end,
    })

    -- == Scrollbar/Search
    -- ---------------------
    use({
      "winston0410/range-highlight.nvim",
      requires = { "winston0410/cmd-parser.nvim" },
      config = function()
        require("range-highlight").setup()
      end,
    })
    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("neoscroll").setup()
      end,
    })
    use({
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("config.search")
      end,
    })
    use({
      "petertriho/nvim-scrollbar",
      after = "nvim-hlslens",
      config = function()
        require("config.scrollbar")
      end,
    })

    -- == Color Highlight
    -- --------------------
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufEnter",
      config = function()
        require("colorizer").setup({
          css = { css = true },
          typescript = { css = true },
          javascript = { css = true },
          typescriptreact = { css = true },
          javascriptreact = { css = true },
          html = { css = true },
        })
      end,
    })

    -- == Indent Lines
    -- --------------------
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufEnter",
      config = function()
        require("config.indentline")
      end,
    })

    -- ----------------
    --  === Git
    -- ----------------
    use({
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      after = "plenary.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    })
    use({ "f-person/git-blame.nvim", cmd = { "GitBlameToggle", "GitBlameEnable" } })
    use({ "rhysd/git-messenger.vim" })
    use({
      "sindrets/diffview.nvim",
      after = "plenary.nvim",
      config = function()
        require("diffview").setup()
      end,
    })

    -- -------------------
    -- === Misc / Random
    -- -------------------
    use({ "andweeb/presence.nvim", event = "BufEnter" })
  end,
})

-- use "chaoren/vim-wordmotion"
-- use "moll/vim-bbye"
-- use "9mm/vim-closer"
-- use {"thinca/vim-ref"}

-- use {"lambdalisue/gina.vim", config = [[require('config.gina')]]}

-- use {"eugen0329/vim-esearch"} -- the best of the best way to search
-- use {"haya14busa/vim-asterisk"} -- smartcase star

-- use "tpope/vim-abolish"
-- use "wellle/targets.vim"
-- use "kana/vim-repeat"
-- use { "matze/vim-move", config = [[require"config.movement"]] }

-- use {
--   "danro/rename.vim",
--   cmd = {"Rename"}
-- }
--
