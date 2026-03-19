local M = {}

---@param opts? lsp.Client.format
function M.format(opts)
  local config = require("cantrip").get_config()
  local opts = vim.tbl_deep_extend("force", {}, opts or {}, config.lsp.format or {})
  local ok, conform = pcall(require, "conform")
  -- use conform for formatting with LSP when available,
  -- since it has better format diffing
  if ok then
    opts.formatters = {}
    conform.format(opts)
  else
    vim.lsp.buf.format(opts)
  end
end

M.formatters = {}

function M.run_formatters(opts)
  local notify = require("fidget").notify
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  if not ((opts and opts.force) or buf) then
    return
  end
  for _, formatter in ipairs(M.formatters) do
    local clients = formatter.enabled_clients(buf)
    local client = clients[1];
    if client then
      notify("Formatting with " .. formatter.name)
      formatter.format({ bufnr = buf })
    end
  end
end

function M.register(formatter)
  M.formatters[#M.formatters + 1] = formatter
  -- table.sort(M.formatters, function(a, b)
  --   return a.priority > b.priority
  -- end)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("CantripFormat", { clear = false })

  M.register({
    name = "LSP",
    format = M.format,
    enabled_clients = function(buf)
      local clients = vim.lsp.get_clients({ bufnr = buf })
      ---@param client vim.lsp.Client
      local format_supported = vim.tbl_filter(function(client)
        return client:supports_method("textDocument/formatting")
            or client:supports_method("textDocument/rangeFormatting")
      end, clients)
      ---@param client vim.lsp.Client
      return vim.tbl_map(function(client)
        return client.name
      end, format_supported)
    end
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    callback = function(event)
      M.run_formatters({ buf = event.buf })
    end,
    desc = "[lsp] format on save",
  })
end

return M
