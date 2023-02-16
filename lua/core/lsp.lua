local M = {}

local oConfig = require("config.other")

M.symbol = function(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

M.handlers = function()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = { prefix = "", spacing = 0 },
    signs = true,
    underline = true,
    update_in_insert = false, -- update diagnostics insert mode
  })
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
end

M.capabilities = function(opts)
  local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  local base_capabilities = vim.lsp.protocol.make_client_capabilities()
  base_capabilities.textDocument.completion.completionItem.documentationFormat = {
    "markdown",
    "plaintext",
  }
  base_capabilities.textDocument.completion.completionItem.snippetSupport = true
  base_capabilities.textDocument.completion.completionItem.preselectSupport = true
  base_capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  base_capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  base_capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  base_capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  base_capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = { 1 },
  }
  base_capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }

  opts.capabilities = vim.tbl_deep_extend(
    "keep",
    opts.capabilities or {},
    base_capabilities,
    cmp_capabilities,
    require("lsp-status").capabilities or {}
  )

  return opts
end

M.lspkind = function()
  local present, lspkind = pcall(require, "lspkind")
  if not present then
    return
  end
  lspkind.init({ symbol_map = oConfig.kind_symbols() })
end

M.lsp_organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

return M
