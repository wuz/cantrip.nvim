return {
  {
    "b0o/incline.nvim",
    opts = function(_, opts)
      local navic = require("nvim-navic")
      local devicons = require("mini.icons")
      local lackluster = require("lackluster")
      local color = lackluster.color -- blue, green, red, orange, black, lack, luster, gray1-9
      return vim.tbl_deep_extend("force", opts, {
        window = {
          placement = {
            vertical = "bottom",
            horizontal = "right",
          },
          padding = 2,
        },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get("file", filename)

          local function get_git_diff()
            local icons = { removed = " ", changed = " ", added = " " }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "| " })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = { error = " ", warn = " ", info = " ", hint = " " }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "| " })
            end
            return label
          end

          local function get_harpoon_items()
            local miniharp = require("miniharp")
            local marks = miniharp.list()
            local current_file_path = vim.fn.expand("%:p:.")
            local label = {}

            for id, item in ipairs(marks) do
              if item.value == current_file_path then
                table.insert(label, { id .. " ", guifg = color.luster, gui = "bold" })
              else
                table.insert(label, { id .. " ", guifg = color.gray5 })
              end
            end

            if #label > 0 then
              table.insert(label, 1, { "󰛢 ", guifg = color.blue })
              table.insert(label, { "| " })
            end
            return label
          end

          -- Get parent folder name and buffer name
          local parentFolder = vim.fn.fnamemodify(bufname, ":h:t")

          -- Next.js matching patterns
          local patterns = {
            ["page"] = "Page",
            ["layout"] = "Layout",
            ["loading"] = "Loading",
            ["not%-found"] = "Not Found",
            ["error"] = "Error",
            ["route"] = "Route",
            ["template"] = "Template",
          }

          -- Get the base filename without extension to be account for (.js,.ts,.jsx.tsx)
          local baseName = vim.fn.fnamemodify(filename, ":r:t")

          -- Match against the patterns and format accordingly
          for file, label in pairs(patterns) do
            if baseName:match("^" .. file .. "$") and parentFolder then
              filename = parentFolder .. "/" .. label
            end
          end

          local function get_file_name()
            local label = {}
            table.insert(label, { (ft_icon or "") .. " ", group = ft_color })
            table.insert(label, { vim.bo[props.buf].modified and " " or "", guifg = color.orange })
            table.insert(label, { filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" })
            if not props.focused then
              label["group"] = "BufferInactive"
            end

            return label
          end

          local res = {
            {
              { get_diagnostic_label() },
              { get_git_diff() },
              { get_harpoon_items() },
              { get_file_name() },
            },
          }

          if props.focused then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
              table.insert(res, {
                { " > ",     group = "NavicSeparator" },
                { item.icon, group = "NavicIcons" .. item.type },
                { item.name, group = "NavicText" },
              })
            end
          end
          return res
        end,
      })
    end,
  },
}
