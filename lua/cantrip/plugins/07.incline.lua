
return {
  {
    "b0o/incline.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    event = "VeryLazy",
    opts = {
      window = {
        placement = {
          vertical = "bottom",
          horizontal = "center",
        },
        padding = 0,
        margin = { vertical = 0, horizontal = 0 },
      },
      hide = {
        cursorline = true,
      },
      render = function(props)
        local helpers = require("incline.helpers")
        local lsp_status = require("lsp-status")
        local navic = require("nvim-navic")
        local devicons = require("nvim-web-devicons")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local res = {}
        table.insert(res, {
          { " [ ", group = "NavicSeparator" },
          { lsp_status.status() },
          { " ] ", group = "NavicSeparator" },
        })
        table.insert(res, {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          guibg = "#44406e",
        })
        if props.focused then
          for _, item in ipairs(navic.get_data(props.buf) or {}) do
            table.insert(res, {
              { " > ", group = "NavicSeparator" },
              { item.icon, group = "NavicIcons" .. item.type },
              { item.name, group = "NavicText" },
            })
          end
        end
        table.insert(res, " ")
        return res
      end,
    },
    config = true,
  },
}
