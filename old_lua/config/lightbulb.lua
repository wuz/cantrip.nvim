require("nvim-lightbulb").update_lightbulb({
  ignore = { "null-ls" },
  sign = {
    enabled = true,
  },
})

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
