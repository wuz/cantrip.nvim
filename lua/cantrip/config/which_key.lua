---@class wk.Opts
return {
  ---@type false | "classic" | "modern" | "helix"
  preset = "helix",
  plugins = {
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  keys = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  ---@type wk.Spec
  spec = {
    mode = { "n", "v" },
    { "<leader><tab>", group = "tabs" },
    { "<leader>c", group = "code" },
    { "<leader>f", group = "file/find" },
    { "<leader>g", group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<leader>q", group = "quickfix" },
    { "<leader>s", group = "search" },
    { "<leader>f", group = "Find" },
    { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
    { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
    { "[", group = "prev" },
    { "]", group = "next" },
    { "g", group = "goto" },
    { "gs", group = "surround" },
    { "z", group = "fold" },
    {
      "<leader>b",
      group = "buffer",
      expand = function()
        return require("which-key.extras").expand.buf()
      end,
    },
    {
      "<leader>w",
      group = "windows",
      proxy = "<c-w>",
      expand = function()
        return require("which-key.extras").expand.win()
      end,
    },
    -- better descriptions
    { "gx", desc = "Open with system app" },
  },
}
