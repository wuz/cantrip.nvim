local Cantrip = require("cantrip.utils")

return {
  {
    "MunifTanjim/nui.nvim",
  },
  -- Better ui.select and ui.input
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  -- mini.icons with nvim web devicon mocking
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      MiniIcons = require("mini.icons")
      MiniIcons.setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  -- Line intend highlights
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
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()

      vim.cmd([[
  noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
              \<Cmd>lua require('hlslens').start()<CR>
  noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
              \<Cmd>lua require('hlslens').start()<CR>
  noremap * *<Cmd>lua require('hlslens').start()<CR>
  noremap # #<Cmd>lua require('hlslens').start()<CR>
  noremap g* g*<Cmd>lua require('hlslens').start()<CR>
  noremap g# g#<Cmd>lua require('hlslens').start()<CR>

  nnoremap <silent> <leader>l :noh<CR>
  ]])
    end,
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
}
