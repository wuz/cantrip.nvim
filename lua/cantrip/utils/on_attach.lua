function on_attach(prev_on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      prev_on_attach(client, buffer)
    end,
  })
end

return on_attach
