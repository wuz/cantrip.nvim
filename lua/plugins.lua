local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local execute = vim.api.nvim_command

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
    use {"https://git.sr.ht/~wuz/scuttle.vim", as = "scuttle", config = [[require('config.scuttle')]]}

    -- ┌───────────────────────────────────────────────────────────────────┐
    -- │ █ Main                                                            │
    -- └───────────────────────────────────────────────────────────────────┘

    --        Style
    -- ─────────────────────────────────────────────────────────────────────
    use {"ntk148v/vim-horizon"}
    use {"https://git.sr.ht/~wuz/warlock"}
    use {"wbthomason/vim-nazgul"}
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require "nvim-web-devicons".setup {
          default = true
        }
      end
    }
    use {
      "mhinz/vim-startify",
      requires = {"kyazdani42/nvim-web-devicons"},
      config = [[require'config.startify']]
    }
    use {
      "glepnir/galaxyline.nvim",
      branch = "main",
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
      "onsails/lspkind-nvim",
      "neovim/nvim-lspconfig",
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
        {"hrsh7th/vim-vsnip", opt = true},
        {"hrsh7th/vim-vsnip-integ", opt = true}
      },
      config = [[require('config.compe')]]
    }

    --        General Functionality
    -- ─────────────────────────────────────────────────────────────────────

    use "chaoren/vim-wordmotion"
    use {
      "moll/vim-bbye",
      config=[[
		nnoremap <Leader>q :Bdelete<CR>
	]]
    }
    use "Shougo/context_filetype.vim"
    use "tpope/vim-endwise"
    use "9mm/vim-closer"
    use "tyru/caw.vim"
    use {
      "lambdalisue/fern.vim",
      requires = {
        "antoinemadec/FixCursorHold.nvim",
        "kyazdani42/nvim-web-devicons",
        "lambdalisue/nerdfont.vim",
        "lambdalisue/fern-renderer-nerdfont.vim",
        {
          "lambdalisue/glyph-palette.vim",
          config = [[require('config.glyph')]]
        },
        "lambdalisue/fern-git-status.vim",
        "lambdalisue/fern-mapping-git.vim"
      },
      config = [[require'config.fern']]
    }
    use {
      "norcalli/nvim-colorizer.lua",
      ft = {"css", "javascript", "vim", "html"},
      config = [[require('colorizer').setup {'css', 'javascript', 'vim', 'html'}]]
    }

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

    -- ┌────────────────────────────────────────────────────────────────-──┐
    -- │ █ Search                                                          │
    -- └───────────────────────────────────────────────────────────────────┘
    use {"jesseleite/vim-agriculture", config = [[require('config.agriculture')]]}
    use {"junegunn/fzf"} -- fzf binary
    use {"junegunn/fzf.vim", config = [[require('config.fzf')]]} -- fzf vim bindings
    use {"pbogut/fzf-mru.vim"} -- fzf mru source
    use {"yuki-ycino/fzf-preview.vim"} -- integration fzf preview with coc
    use {"eugen0329/vim-esearch"} -- the best of the best way to search
    use {"romgrk/searchReplace.vim"} -- better search and replace
    use {"svermeulen/vim-subversive"} -- fast substitute
    use {"haya14busa/vim-asterisk"} -- smartcase star

    use "tpope/vim-surround"
    use "mhinz/vim-signify"
    use "tpope/vim-abolish"
    use "easymotion/vim-easymotion"
    use "wellle/targets.vim"
    use "xolox/vim-reload"
    use "xolox/vim-misc"
    use "tpope/vim-fugitive"
    use "tpope/vim-repeat"
    use "christoomey/vim-conflicted"
    use "matze/vim-move"

    -- ┌────────────────────────────────────────────────────────────────-──┐
    -- │ █ Lazy                                                            │
    -- └───────────────────────────────────────────────────────────────────┘

    use {
      "rhysd/git-messenger.vim",
      cmd = "GitMessenger",
      keys = "<Plug>(git-messenger)",
      requires = {"scuttle"},
      run = [[
		nmap <Leader>, :GitMessenger<CR>
		]]
    }

    use {
      "danro/rename.vim",
      cmd = {"Rename"}
    }
    use {"ap/vim-css-color", ft = {"css", "scss", "sass", "less"}}

    use {"thinca/vim-ft-diff_fold", ft = "diff"}
    use {"thinca/vim-ft-help_fold", ft = "help"}
  end
)
