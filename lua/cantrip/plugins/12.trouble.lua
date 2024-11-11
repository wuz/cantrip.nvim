return {
  {
    "folke/trouble.nvim",
    dependencies = { "echasnovski/mini.icons" },
    keys = {
      {
        "<leader>xx",
        function()
          require("trouble").toggle()
        end,
      },
      {
        "<leader>xd",
        function()
          require("trouble").toggle("diagnostics")
        end,
      },
      {
        "<leader>xq",
        function()
          require("trouble").toggle("quickfix")
        end,
      },
      {
        "<leader>xl",
        function()
          require("trouble").toggle("loclist")
        end,
      },
      {
        "gR",
        function()
          require("trouble").toggle("lsp_references")
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd({ "BufLeave" }, {
        callback = function()
          local num_windows = vim.fn.winnr("$")
          if num_windows == 1 and vim.bo.filetype == "Trouble" then
            require("trouble").close()
          end
        end,
      })
    end,
    opts = {
      modes = {
        diagnostics = {},
      },
    },
  },
}
