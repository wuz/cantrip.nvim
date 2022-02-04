require("nvim-lightbulb").update_lightbulb({
  ignore = { "null-ls", "solargraph" },
  sign = {
    enabled = false,
  },
  virtual_text = {
    enabled = true,
    -- Text to show at virtual text
    text = "💡",
  },
})

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
