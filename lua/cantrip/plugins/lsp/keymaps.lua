local M = {}

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
  local format = require("cantrip.plugins.lsp.format").format
  local live_rename = require("live-rename")

  if not M._keys then
    ---@class PluginLspKeys
    -- stylua: ignore
    M._keys = {
      { "<leader>cd", vim.diagnostic.open_float,                     desc = "Line Diagnostics" },
      { "<leader>cl", "<cmd>LspInfo<cr>",                            desc = "Lsp Info" },
      { "gd",         vim.lsp.buf.definition,                        desc = "Goto Definition" },
      { "gr",         vim.lsp.buf.references,                        desc = "References" },
      { "gi",         vim.lsp.buf.implementation,                    desc = "Goto Implementation" },
      { "gt",         vim.lsp.buf.type_definition,                   desc = "Goto Type Definition" },
      { 'gD',         '<CMD>Glance definitions<CR>',                 desc = "Glance definitions" },
      { 'gR',         '<CMD>Glance references<CR>',                  desc = "Glance references" },
      { 'gT',         '<CMD>Glance type_definitions<CR>',            desc = "Glance type definitions" },
      { 'gI',         '<CMD>Glance implementations<CR>',             desc = "Glance implementations", },
      { "K",          vim.lsp.buf.hover,                             desc = "Hover" },
      { "gK",         vim.lsp.buf.signature_help,                    desc = "Signature Help",         has = "signatureHelp" },
      { "<c-k>",      vim.lsp.buf.signature_help,                    mode = "i",                      desc = "Signature Help",   has = "signatureHelp" },
      { "]d",         M.diagnostic_goto(true),                       desc = "Next Diagnostic" },
      { "[d",         M.diagnostic_goto(false),                      desc = "Prev Diagnostic" },
      { "]e",         M.diagnostic_goto(true, "ERROR"),              desc = "Next Error" },
      { "[e",         M.diagnostic_goto(false, "ERROR"),             desc = "Prev Error" },
      { "]w",         M.diagnostic_goto(true, "WARN"),               desc = "Next Warning" },
      { "[w",         M.diagnostic_goto(false, "WARN"),              desc = "Prev Warning" },
      { "<leader>ca", vim.lsp.buf.code_action,                       desc = "Code Action",            mode = { "n", "v" },       has = "codeAction" },
      { "<leader>cf", format,                                        desc = "Format Document",        has = "documentFormatting" },
      { "<leader>cf", format,                                        desc = "Format Range",           mode = "v",                has = "documentRangeFormatting" },
      -- { "<leader>cr", vim.lsp.buf.rename,                            desc = "Rename",                 has = "rename" },
      { "<leader>cr", live_rename.rename,                            desc = "LSP rename" },
      { "<leader>cR", live_rename.map({ text = "", insert = true }), desc = "LSP rename" }
    }
  end
  return M._keys
end

function M.on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

  for _, value in ipairs(M.get()) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = true
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

return M
