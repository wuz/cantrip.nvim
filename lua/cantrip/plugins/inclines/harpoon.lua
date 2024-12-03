return {
  {
    "b0o/incline.nvim",
    opts = function(_, opts)
      local helpers = require("incline.helpers")
      local navic = require("nvim-navic")
      local devicons = require("nvim-web-devicons")
      return vim.tbl_deep_extend("force", opts, {
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
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

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

          local function custom_buffer_name()
            -- Return blank name if no matches found
            return output
          end

          local function get_harpoon_items()
            local harpoon = require("harpoon")
            local marks = harpoon:list().items
            local current_file_path = vim.fn.expand("%:p:.")
            local label = {}

            for id, item in ipairs(marks) do
              if item.value == current_file_path then
                table.insert(label, { id .. " ", guifg = "#FFFFFF", gui = "bold" })
              else
                table.insert(label, { id .. " ", guifg = "#434852" })
              end
            end

            if #label > 0 then
              table.insert(label, 1, { "󰛢 ", guifg = "#61AfEf" })
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
            table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
            table.insert(label, { vim.bo[props.buf].modified and " " or "", guifg = "#d19a66" })
            table.insert(label, { filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" })
            if not props.focused then
              label["group"] = "BufferInactive"
            end

            return label
          end

          -- local function get_lint_progress()
          --   local linters = require("lint").get_running()
          --   if #linters == 0 then
          --     return "󰦕"
          --   end
          --   return "󱉶 " .. table.concat(linters, ", ")
          -- end

          local res = {
            {
              { get_diagnostic_label() },
              { get_git_diff() },
              { get_harpoon_items() },
              { get_file_name() },
              { custom_buffer_name() },
              guibg = "#0e0e0e",
            },
          }

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
          -- table.insert(res, {
          --   { get_lint_progress() },
          -- })
          table.insert(res, " ")
          return res
        end,
      })
    end,
  },
}
