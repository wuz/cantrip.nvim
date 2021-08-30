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
  function()
    -- ┌───────────────────────────────────────────────────────────────────┐
    -- │ █ Packer/Lua/Builtin                                              │
    -- └───────────────────────────────────────────────────────────────────┘

    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}
    -- use {'svermeulen/nvim-moonmaker'}
    -- use {"https://git.sr.ht/~wuz/scuttle.vim", as = "scuttle", config = [[require('config.scuttle')]]}
    use {"folke/which-key.nvim", config = [[require'config.which_key']]}

    -- ┌───────────────────────────────────────────────────────────────────┐
    -- │ █ Main                                                            │
    -- └───────────────────────────────────────────────────────────────────┘

    --        Style
    -- ─────────────────────────────────────────────────────────────────────
    use {"ntk148v/vim-horizon"}
    use {"DankNeon/vim"}
    -- use {"https://git.sr.ht/~wuz/warlock"}
    use {"wbthomason/vim-nazgul"}
    use {"yashguptaz/calvera-dark.nvim"}
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
      "romgrk/barbar.nvim",
      requires = {"kyazdani42/nvim-web-devicons"},
      config = [[require'config.barbar']]
    }
    use {
      "glepnir/dashboard-nvim",
      config = [[require'config.dashboard']]
    }
    -- use {
    --   "mhinz/vim-startify",
    --   requires = {"kyazdani42/nvim-web-devicons"},
    --   config = [[require'config.startify']]
    -- }
    use {
      "hoob3rt/lualine.nvim",
      config = [[require'config.statusline']],
      requires = {"kyazdani42/nvim-web-devicons"}
    }
    use {"yggdroot/indentLine", setup = [[require('config.indentline')]]}

    --        Formatting
    -- ─────────────────────────────────────────────────────────────────────
    use {"junegunn/vim-easy-align", config = [[require('config.easy_align')]]}
    use {"mhartington/formatter.nvim", run = [[npm -g install lua-fmt]], config = [[require('config.format')]]}

    --        LSP
    -- ─────────────────────────────────────────────────────────────────────
    use {
      {"kosayoda/nvim-lightbulb", config = [[require'config.lightbulb']]},
      "glepnir/lspsaga.nvim",
      "onsails/lspkind-nvim",
      "anott03/nvim-lspinstall",
      "simrat39/symbols-outline.nvim",
      {
        "neovim/nvim-lspconfig",
        config = [[require'config.lsp']]
      },
      "nvim-lua/lsp-status.nvim",
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
          "nvim-treesitter/nvim-treesitter-refactor",
          "nvim-treesitter/nvim-treesitter-textobjects",
          {
            -- for all syntax not supported by treesitter
            "sheerun/vim-polyglot",
            config = [[require'config.polyglot']]
          }
        },
        config = [[require('config.treesitter')]]
      }
    }

    --        Autocomplete
    -- ─────────────────────────────────────────────────────────────────────

    use {
      "hrsh7th/nvim-compe",
      requires = {
        {"L3MON4D3/LuaSnip"}
      },
      config = [[require('config.compe')]]
    }

    --        General Functionality
    -- ─────────────────────────────────────────────────────────────────────

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = [[require'config.trouble']]
    }
    use {"gelguy/wilder.nvim", requires = "romgrk/fzy-lua-native", config = [[require'config.wilder']]}
    use "chaoren/vim-wordmotion"
    use "moll/vim-bbye"
    use {
      "Shougo/context_filetype.vim",
      requires = {
        "joker1007/vim-ruby-heredoc-syntax"
      }
    }
    use "tpope/vim-endwise"
    use "9mm/vim-closer"
    use "tyru/caw.vim"
    -- use {
    --   "lambdalisue/fern.vim",
    --   requires = {
    --     "antoinemadec/FixCursorHold.nvim",
    --     "kyazdani42/nvim-web-devicons",
    --     "lambdalisue/nerdfont.vim",
    --     "lambdalisue/fern-renderer-nerdfont.vim",
    --     {
    --       "lambdalisue/glyph-palette.vim",
    --       config = [[require('config.glyph')]]
    --     },
    --     "yuki-yano/fern-preview.vim",
    --     "lambdalisue/fern-git-status.vim",
    --     "lambdalisue/fern-mapping-git.vim",
    --     "lambdalisue/fern-hijack.vim"
    --   },
    --   config = [[require'config.fern']]
    -- }
    use {
      "norcalli/nvim-colorizer.lua",
      ft = {"css", "javascript", "vim", "html"},
      config = [[require('colorizer').setup {'css', 'javascript', 'vim', 'html'}]]
    }

    use {"ojroques/nvim-bufdel"}
    use {"thinca/vim-ref"}

    -- ┌───────────────────────────────────────────────────────────────────┐
    -- │ █ Git                                                             │
    -- └───────────────────────────────────────────────────────────────────┘

    use {"lambdalisue/gina.vim", config = [[require('config.gina')]]}
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

    -- ┌────────────────────────────────────────────────────────────────-──┐
    -- │ █ Search                                                          │
    -- └───────────────────────────────────────────────────────────────────┘
    use {
      "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
      config = [[require('config.telescope')]]
    }
    use {"eugen0329/vim-esearch"} -- the best of the best way to search
    use {"svermeulen/vim-subversive"} -- fast substitute
    use {"haya14busa/vim-asterisk"} -- smartcase star

    use "tpope/vim-surround"
    use "mhinz/vim-signify"
    use "tpope/vim-abolish"
    -- use "easymotion/vim-easymotion"
    use "wellle/targets.vim"
    use "xolox/vim-reload"
    use "xolox/vim-misc"
    use "tpope/vim-fugitive"
    use "kana/vim-repeat"
    use "christoomey/vim-conflicted"
    use "matze/vim-move"

    -- ┌────────────────────────────────────────────────────────────────-──┐
    -- │ █ Lazy                                                            │
    -- └───────────────────────────────────────────────────────────────────┘

    use {
      "danro/rename.vim",
      cmd = {"Rename"}
    }
    use {"ap/vim-css-color", ft = {"css", "scss", "sass", "less"}}

    use {"thinca/vim-ft-diff_fold", ft = "diff"}
    use {"thinca/vim-ft-help_fold", ft = "help"}
  end
)
