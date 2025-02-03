return {
  plugins = { spelling = true },
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
