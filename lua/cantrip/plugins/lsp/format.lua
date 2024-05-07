local notify = require("fidget").notify
local M = {}

function M.format(async, client)
  local config = require("cantrip").getConfig()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype

  notify("Formatting with " .. client.name)
  vim.lsp.buf.format(config.lsp.format)
  -- local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  -- vim.lsp.buf.format(vim.tbl_deep_extend("force", {
  --   bufnr = buf,
  --   async = async,
  --   filter = function(client)
  --     if have_nls then
  --       return client.name == "null-ls"
  --     end
  --     return client.name ~= "null-ls"
  --   end,
  -- }, config.lsp.format or {}))
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
