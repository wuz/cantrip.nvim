local present, packer = pcall(require, "packerinit")
if not present then
  return false
end

return require("packer").startup({
  function()
    -- --------------
    -- === BUILTINS
    -- --------------
    use({
      "chentoast/marks.nvim",
      config = function()
        require("config.other").marks()
      end,
    })
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

    -- == LSP
    -- ----------------
    -- use({ "Maan2003/lsp_lines.nvim", after = "nvim-lspconfig" })

    -- ----------------
    --  === Git
    -- ----------------
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
