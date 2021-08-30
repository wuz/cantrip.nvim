require("which-key").setup {
  plugins = {
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20 -- how many suggestions should be shown in the list?
    }
  },
  operators = {gc = "Comments"},
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "->", -- symbol used between a key and it's label
    group = "+" -- symbol prepended to a group
  },
  window = {
    border = "shadow", -- none, single, double, shadow
    position = "top", -- bottom, top
    margin = {0, 2, 0, 2}, -- extra window margin [top, right, bottom, left]
    padding = {1, 0, 1, 0} -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = {min = 1, max = 10}, -- min and max height of the columns
    width = {min = 20, max = 50}, -- min and max width of the columns
    spacing = 2, -- spacing between columns
    align = "left" -- align columns left, center or right
  },
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto" -- automatically setup triggers
}
