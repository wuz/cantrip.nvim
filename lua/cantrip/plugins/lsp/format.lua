local notify = require("fidget").notify
local M = {}

function M.format(async, client)
  local config = require("cantrip").getConfig()
  notify("Formatting with " .. client.name)
  vim.lsp.buf.format(config.lsp.format)
end

function M.on_attach(client, buf)
  local group = vim.api.nvim_create_augroup("LspFormat." .. buf, { clear = false })
  local event = "BufWritePre" -- or "BufWritePost"
  local async = event == "BufWritePost"

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd(event, {
      group = group,
      buffer = buf,
      callback = function()
        M.format(async, client)
      end,
      desc = "[lsp] format on save",
    })
  end
end

return M
