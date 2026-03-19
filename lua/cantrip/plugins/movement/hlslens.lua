return {
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
}
