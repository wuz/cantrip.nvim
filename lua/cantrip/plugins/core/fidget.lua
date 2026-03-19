return {
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        view = {
          stack_upwards = true, -- Display notification items from bottom to top
          align = "message", -- Indent messages longer than a single line
          reflow = false, -- Reflow (wrap) messages wider than notification window
          icon_separator = " ", -- Separator between group name and icon
          group_separator = "---", -- Separator between notification groups
          -- Highlight group used for group separator
          group_separator_hl = "Comment",
          line_margin = 1, -- Spaces to pad both sides of each non-empty line
          -- How to render notification messages
        },

        -- Options related to the notification window and buffer
        window = {
          normal_hl = "Comment", -- Base highlight group in the notification window
          winblend = 100, -- Background color opacity in the notification window
          border = "none", -- Border around the notification window
          zindex = 45, -- Stacking priority of the notification window
          max_width = 0, -- Maximum width of the notification window
          max_height = 0, -- Maximum height of the notification window
          x_padding = 1, -- Padding from right edge of window boundary
          y_padding = 3, -- Padding from bottom edge of window boundary
          align = "bottom", -- How to align the notification window
          relative = "editor", -- What the notification window position is relative to
          avoid = { "oil", "snacks_dashboard" }, -- Filetypes the notification window should avoid
          -- e.g., { "aerial", "NvimTree", "neotest-summary" }
        },
      },
    },
  },
}
