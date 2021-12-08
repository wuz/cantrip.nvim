local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local execute = vim.api.nvim_command

vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")

if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute("packadd packer.nvim")
end

vim.cmd [[packadd packer.nvim]]

return require "packer".startup(
  {
    function()
      -- ┌───────────────────────────────────────────────────────────────────┐
      -- │ █ Packer/Lua/Builtin                                              │
      -- └───────────────────────────────────────────────────────────────────┘

      -- Packer can manage itself as an optional plugin
      use {"wbthomason/packer.nvim", opt = true}
      use { "lewis6991/impatient.nvim" }
      -- use {"folke/which-key.nvim", config = [[require'config.which_key']]}
      use {"antoinemadec/FixCursorHold.nvim"}
      use {"nvim-lua/popup.nvim", requries = "nvim-lua/plenary.nvim"}
      use { "rcarriga/nvim-notify", config = [[require'config.notify']] }

      -- ┌───────────────────────────────────────────────────────────────────┐
      -- │ █ Style/Appearance                                                │
      -- └───────────────────────────────────────────────────────────────────┘
      -- use {"ntk148v/vim-horizon"}
      -- use {"DankNeon/vim"}
      -- use {"wbthomason/vim-nazgul"}
      -- use {"yashguptaz/calvera-dark.nvim"}
      --
      use {"wadackel/vim-dogrun"}
      use {"folke/lsp-colors.nvim"}
      use {
        "kyazdani42/nvim-web-devicons",
        config = function()
          require "nvim-web-devicons".setup {
            default = true
          }
        end
      }
      use {"folke/twilight.nvim", config = [[require'config.twilight']]}
      use {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = [[require'config.tree']]
      }
      use {
        "noib3/cokeline.nvim",
        requires = {"kyazdani42/nvim-web-devicons"},
        config = [[require'config.bufferline']]
      }
      use "mhinz/vim-signify"
      use {
        "glepnir/dashboard-nvim",
        config = [[require"config.dashboard"]]
      }
      use {
        "hoob3rt/lualine.nvim",
        config = [[require'config.statusline']],
        requires = {"kyazdani42/nvim-web-devicons"}
      }
      use {"yggdroot/indentLine", setup = [[require"config.indentline"]]}

      --        Formatting
      -- ─────────────────────────────────────────────────────────────────────
      -- use {"junegunn/vim-easy-align", config = [[require('config.easy_align')]]}
      -- use {"mhartington/formatter.nvim", run = [[npm -g install lua-fmt]], config = [[require('config.format')]]}

      --        LSP
      -- ─────────────────────────────────────────────────────────────────────
      use { 
        "williamboman/nvim-lsp-installer", 
        after = "cmp-nvim-lsp",
        config = [[require'config.lsp']],
        requires = {
          { 
            "jose-elias-alvarez/null-ls.nvim",
            requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
            config = [[require"config.format"]]
          },
          "neovim/nvim-lspconfig",
          "glepnir/lspsaga.nvim",
          "nvim-lua/lsp-status.nvim",
          "ray-x/lsp_signature.nvim",
          "onsails/lspkind-nvim",
          {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            requires = {
              "nvim-treesitter/nvim-treesitter-refactor",
              {"windwp/nvim-autopairs", config = [[require"config.autopairs"]] },
              "nvim-treesitter/nvim-treesitter-textobjects",
              "windwp/nvim-ts-autotag",
              "andymass/vim-matchup",
              {
                -- for all syntax not supported by treesitter
                "sheerun/vim-polyglot",
                config = [[require'config.polyglot']]
              }
            },
            config = [[require('config.treesitter')]]
          }
        }
      }
      -- use {
      --   {"kosayoda/nvim-lightbulb", config = [[require'config.lightbulb']]},
      --   "simrat39/symbols-outline.nvim",
      -- }


      -- ┌───────────────────────────────────────────────────────────────────┐
      -- │ █ Autocomplete                                                    │
      -- └───────────────────────────────────────────────────────────────────┘

      use {
        "hrsh7th/cmp-nvim-lsp",
        config = [[require"config.completion"]],
        requires = {
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-cmdline",
          "hrsh7th/nvim-cmp",
          "L3MON4D3/LuaSnip",
          "saadparwaiz1/cmp_luasnip",
        }
      }

      -- ┌───────────────────────────────────────────────────────────────────┐
      -- │ █ General Functionality                                           │
      -- └───────────────────────────────────────────────────────────────────┘

      use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = [[require'config.trouble']]
      }
      -- use { "karb94/neoscroll.nvim", config = [[require('neoscroll').setup()]] }
      -- use {"gelguy/wilder.nvim", requires = "romgrk/fzy-lua-native", config = [[require'config.wilder']]}
      -- use "chaoren/vim-wordmotion"
      -- use "moll/vim-bbye"
      use {
        "Shougo/context_filetype.vim",
        requires = {
          { "joker1007/vim-ruby-heredoc-syntax", ft = {"ruby"} }
        }
      }
      -- -- use "tpope/vim-endwise"
      -- use "9mm/vim-closer"
      use "tyru/caw.vim"
      -- use {
      --   "norcalli/nvim-colorizer.lua",
      --   config = [[require('colorizer').setup()]]
      -- }
      -- use {
      --   "max397574/better-escape.nvim",
      --   config = function()
      --     require("better_escape").setup()
      --   end,
      -- }
      -- use {"thinca/vim-ref"}

      -- ┌───────────────────────────────────────────────────────────────────┐
      -- │ █ Git                                                             │
      -- └───────────────────────────────────────────────────────────────────┘

      -- use {"lambdalisue/gina.vim", config = [[require('config.gina')]]}
      use {
        "lewis6991/gitsigns.nvim",
        requires = {
          "nvim-lua/plenary.nvim"
        },
        config = function()
          require("gitsigns").setup()
        end
      }
      use {"f-person/git-blame.nvim"}
      use {"rhysd/git-messenger.vim"}
      -- use "christoomey/vim-conflicted"

      -- ┌───────────────────────────────────────────────────────────────────┐
      -- │ █ Search                                                          │
      -- └───────────────────────────────────────────────────────────────────┘
      use {
        "nvim-telescope/telescope.nvim",
        config = [[require"config.telescope"]]
      }
      -- use {"eugen0329/vim-esearch"} -- the best of the best way to search
      -- use {"haya14busa/vim-asterisk"} -- smartcase star
      -- 
      -- use "tpope/vim-surround"
      -- use "tpope/vim-abolish"
      -- use "wellle/targets.vim"
      -- use "kana/vim-repeat"
      -- use { "matze/vim-move", config = [[require"config.movement"]] }

      -- ┌───────────────────────────────────────────────────────────────────┐
      -- │ █ Misc/Lazy                                                       │
      -- └───────────────────────────────────────────────────────────────────┘

      -- use {
      --   "danro/rename.vim",
      --   cmd = {"Rename"}
      -- }
      -- 
      use {"thinca/vim-ft-diff_fold", ft = "diff"}
      use {"thinca/vim-ft-help_fold", ft = "help"}
    end,
    config = {
      compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
    }
  }
)
