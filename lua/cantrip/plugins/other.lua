return {
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   vscode = true,
  --   ---@type Flash.Config
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- },
  --   {
  --     "hoob3rt/lualine.nvim",
  --     init = function()
  --       vim.cmd("autocmd User LspProgressUpdate let &ro = &ro")
  --     end,
  --     opts = function()
  --       local present, lsp_status = pcall(require, "lsp-status")
  --       local function clock()
  --         return " " .. os.date("%H:%M")
  --       end
  --
  --       local function lsp_progress()
  --         if present and vim.lsp.get_active_clients() > 0 then
  --           lsp_status.status()
  --         end
  --       end
  --       return {
  --         options = {
  --           theme = "tokyonight",
  --           icons_enabled = true,
  --           -- section_separators = {"", ""},
  --           -- component_separators = {"", ""}
  --           component_separators = { left = "", right = "" },
  --           section_separators = { left = "", right = "" },
  --         },
  --         sections = {
  --           lualine_a = { "mode" },
  --           lualine_b = { "branch", "diff" },
  --           lualine_c = { { "diagnostics", sources = { "nvim_diagnostic" } }, { "filename", path = 1 } },
  --           lualine_x = { "filetype", lsp_progress },
  --           lualine_y = { "diff" },
  --           lualine_z = { clock },
  --         },
  --         inactive_sections = {
  --           lualine_a = {},
  --           lualine_b = {},
  --           lualine_c = {},
  --           lualine_x = {},
  --           lualine_y = {},
  --         },
  --       }
  --     end,
  --   },
  -- {
  --   "lukas-reineke/virt-column.nvim",
  --   config = true,
  -- },
  -- {
  --   "ellisonleao/carbon-now.nvim",
  --   opts = {
  --     open_cmd = "open",
  --   },
  --   cmd = "CarbonNow",
  -- },
}
