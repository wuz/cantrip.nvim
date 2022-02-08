local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local execute = vim.api.nvim_command

vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])

return require("packer").startup({
  function()
    -- --------------
    -- === BUILTINS
    -- --------------
    use({ "wbthomason/packer.nvim", opt = true })
    use({ "nvim-lua/plenary.nvim" })
    use({ "Iron-E/nvim-cartographer" })
    use({
      "folke/which-key.nvim",
      config = function()
        require("config.which_key")
      end,
    })
    use({
      "nathom/filetype.nvim",
      config = function()
        vim.g.did_load_filetypes = 1
      end,
    })
    use({ "antoinemadec/FixCursorHold.nvim" })
    use({ "nvim-lua/popup.nvim", requries = "nvim-lua/plenary.nvim" })
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("config.notify")
      end,
    })
    use({
      "ethanholz/nvim-lastplace",
      config = function()
        require("config.other").lastplace()
      end,
    })
    use({
      "https://gitlab.com/yorickpeterse/nvim-pqf.git",
      config = function()
        require("pqf").setup()
      end,
    })
    use({
      "chentau/marks.nvim",
      config = function()
        require("config.other").marks()
      end,
    })
    use({
      "jghauser/mkdir.nvim",
      config = function()
        require("mkdir")
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

    -- --------------------
    -- === Functionality
    -- --------------------

    -- == Motion
    -- ----------------
    use({
      "phaazon/hop.nvim",
      config = function()
        require("config.hop")
      end,
    })
    use({
      "unblevable/quick-scope",
      config = function()
        require("config.other").quickscope()
      end,
    })

    -- == Mappings
    -- ----------------
    use({
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    })

    -- --------------------
    -- === Languages/Code
    -- --------------------

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
      "rcarriga/vim-ultest",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      config = function()
        require("config.other").test()
      end,
    })

    -- == TODOs
    -- ----------------
    use({
      "folke/todo-comments.nvim",
      config = function()
        require("config.other").todo()
      end,
    })

    -- == Filetype
    -- ----------------
    use({ "joker1007/vim-ruby-heredoc-syntax", ft = { "ruby" } })
    use({
      "Shougo/context_filetype.vim",
      event = "BufEnter",
      after = { "vim-ruby-heredoc-syntax" },
    })
    use({ "thinca/vim-ft-diff_fold", ft = "diff" })
    use({ "thinca/vim-ft-help_fold", ft = "help" })

    -- == Comments
    -- ----------------
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("config.other").comment()
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
      run = ":TSUpdate",
      config = function()
        require("config.treesitter")
      end,
    })
    use({"nvim-treesitter/nvim-treesitter-refactor", after="nvim-treesitter" })
    use({"JoosepAlviste/nvim-ts-context-commentstring", after="nvim-treesitter" })
    use({"RRethy/nvim-treesitter-textsubjects", after="nvim-treesitter" })
    use({"nvim-treesitter/nvim-treesitter-textobjects", after="nvim-treesitter" })
    use({"windwp/nvim-ts-autotag", after="nvim-treesitter" })
    use({"andymass/vim-matchup", after="nvim-treesitter" })

    -- for all syntax not supported by treesitter
    use({
      "sheerun/vim-polyglot",
      config = function()
        require("config.polyglot")
      end,
    })
    use({ "ellisonleao/glow.nvim", ft = "markdown" })

    use({
      "danymat/neogen",
      cmd = "Neogen",
      config = function()
        require("neogen").setup({
          enabled = true,
        })
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    })

    -- == Completion
    -- ----------------
    use({
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
    })
    use({
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
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
    use({ "L3MON4D3/LuaSnip", after = "nvim-cmp" })

    -- == Surround
    -- ----------------
    use({
      "blackCauldron7/surround.nvim",
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
    use({
      "williamboman/nvim-lsp-installer",
      after = {
        "nvim-lspconfig",
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

    -- ----------------
    -- === APPEARANCE
    -- ----------------

    -- == Colors
    -- ----------------
    use({ "rktjmp/lush.nvim" })
    use({
      "catppuccin/nvim",
      as = "catppuccin",
    })
    use({ "wuelnerdotexe/vim-enfocado" })
    use({ "folke/tokyonight.nvim" })
    use({
      "stevearc/dressing.nvim",
      config = function()
        require("dressing").setup()
      end,
    })
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
    })

    -- == Dashboard / Startup
    -- ------------------------
    use({
      "glepnir/dashboard-nvim",
      after = "telescope.nvim",
      config = function()
        require("config.dashboard")
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
        require("colorizer").setup()
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
    -- === Git
    -- ----------------
    use({
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      after = "plenary.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    })
    use({ "f-person/git-blame.nvim" })
    use({ "rhysd/git-messenger.vim" })
    use({
      "sindrets/diffview.nvim",
      after = "plenary.nvim",
      config = function()
        require("diffview").setup()
      end,
    })
    use({
      "pwntester/octo.nvim",
      after = "telescope.nvim",
      config = function()
        require("octo").setup()
      end,
    })

    -- -------------------
    -- === Misc / Random
    -- -------------------
    use({ "andweeb/presence.nvim", event = "BufEnter" })
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  },
})

-- use({ "lewis6991/impatient.nvim" })
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
