-- Get the path to cantrip.nvim plugin directory
local function get_cantrip_path()
  local source = debug.getinfo(1, "S").source
  if source:sub(1, 1) == "@" then
    source = source:sub(2)
  end
  -- Go up from lua/cantrip/plugins/core/builtins.lua to the root
  return vim.fn.fnamemodify(source, ":h:h:h:h")
end

return {
  {
    dir = get_cantrip_path() .. "/cantrip/builtins/reverse",
    name = "reverse",
    opts = {},
    keys = {
      {
        "<leader>ct",
        function()
          require("reverse").reverse()
        end,
        desc = "Reverse the lines current selection or file",
        mode = { "n", "v" },
      },
    },
  },
}
