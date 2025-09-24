return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    enabled = false,
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
}
