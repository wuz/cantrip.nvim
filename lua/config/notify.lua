require("notify").setup({
  timeout=2000,
  background_colour = "ColorColumn",
  -- Icons for the different levels
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})
