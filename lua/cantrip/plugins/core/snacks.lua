local Cantrip = require("cantrip.utils")

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      input = { enabled = true },
      indent = { enabled = true },
      scroll = { enabled = true },
      notifier = { enabled = true },
      statuscolumn = { enabled = true },
      styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    },
      ---@class snacks.dashboard.Config
      dashboard = {
        preset = {
          -- stylua: ignore
          header = [[
       .―――――.                       ╔╦╦╦╦╗
   .―――│_   _│           .―.         ║~~~~║
.――│===│― C ―│_          │_│     .――.║~~~~║
│  │===│  A  │'⧹     ┌―――┤~│  ┌――│∰ │╢    ║
│%%│ ⟐ │  N  │.'⧹    │===│ │――│%%│  │║    ║
│%%│ ⟐ │  T  │⧹.'⧹   │⦑⦒ │ │__│  │  │║ ⧊  ║
│  │ ⟐ │  R  │ ⧹.'⧹  │===│ │==│  │  │║    ║
│  │ ⟐ │_ I _│  ⧹.'⧹ │ ⦑⦒│_│__│  │∰ │║~~~~║
│  │===│― P ―│   ⧹.'⧹│===│~│――│%%│――│║~~~~║
╰――╯―――'―――――╯    `―'`―――╯―^――^――^――'╚╩╩╩╩╝
          ⁂ neovim + dark magic ⁂        ]],
        },
      },
    },
    keys = {
      { "<leader>un", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<leader>nh", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
      { "<leader>ps", function() require("snacks").profiler.scratch() end, desc = "Profiler Scratch Buffer" },
    },
    config = function(_, opts)
      local notify = vim.notify
      require("snacks").setup(opts)
      -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
      -- this is needed to have early notifications show up in noice history
      if Cantrip.has("noice.nvim") then
        vim.notify = notify
      end
    end,
  },
}
