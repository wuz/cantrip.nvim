local map = vim.keymap.set
return {
  {
    "rcarriga/nvim-dap-ui",
    event = "BufRead",
    dependencies = { "mfussenegger/nvim-dap", "Pocco81/DAPInstall.nvim" },
    opts = {
      {
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
        },
        layouts = {
          {
            elements = {
              "scopes",
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 10,
            position = "bottom",
          },
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil, -- Floats will be treated as percentage of your screen.
          border = "single", -- Border style. Can be "single", "double" or "rounded"
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
      },
    },
    config = function(_, opts)
      -- Temp fix for bug in setting filetype
      -- https://github.com/rcarriga/nvim-dap-ui/issues/219#issuecomment-1413427313
      vim.schedule(function()
        require("dapui").setup(opts)
      end)
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "olimorris/neotest-rspec",
      "haydenmeade/neotest-jest",
      "nvim-neotest/neotest-vim-test",
      "marilari88/neotest-vitest",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-vim-test")({ ignore_filetypes = { "python", "javascript", "typescript" } }),
          require("neotest-rspec"),
          require("neotest-jest"),
          require("neotest-vitest"),
        },
      }
    end,
    config = function(_, opts)
      local neotest = require("neotest")
      neotest.setup(opts)
      map("n", "<leader>Tf", neotest.run.run(vim.fn.expand("%")), { expr = true, silent = true })
      map("n", "<leader>Tn", neotest.run.run({ strategy = "dap" }), { expr = true, silent = true })
    end,
  },
}
