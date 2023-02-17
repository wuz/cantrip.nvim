local present, packer = pcall(require, "packerinit")
if not present then
  return false
end

return require("packer").startup({
  function()
    -- --------------
    -- === BUILTINS
    -- --------------
    use({ "nvim-lua/plenary.nvim" })
    --use({ "antoinemadec/FixCursorHold.nvim" })
    use({ "nvim-lua/popup.nvim", requries = "nvim-lua/plenary.nvim" })
    use({
      "chentoast/marks.nvim",
      config = function()
        require("config.other").marks()
      end,
    })
    use({ "famiu/bufdelete.nvim" })
    use({ "akinsho/toggleterm.nvim", event = "BufEnter" })

    -- == Motion
    -- ----------------
    use({
      "unblevable/quick-scope",
      config = function()
        require("config.other").quickscope()
      end,
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

    -- == LSP
    -- ----------------
    use({ "tami5/lspsaga.nvim", after = "nvim-lspconfig" })
    use({ "nvim-lua/lsp-status.nvim", after = "nvim-lspconfig" })
    use({ "ray-x/lsp_signature.nvim", after = "nvim-lspconfig" })
    use({ "simrat39/symbols-outline.nvim", after = "nvim-lspconfig" })
    -- Even better lua dev
    use({ "folke/neodev.nvim", after = "nvim-lspconfig" })
    use({ "williamboman/mason-lspconfig.nvim", after = "nvim-lspconfig" })
    use({
      "williamboman/mason.nvim",
      after = {
        "nvim-lspconfig",
        "mason-lspconfig.nvim",
        "lspsaga.nvim",
        "lsp-status.nvim",
        "lsp_signature.nvim",
        "cmp-nvim-lsp",
        "symbols-outline.nvim",
      },
      config = function()
        require("config.lsp")
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
