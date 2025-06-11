return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "llm-ls",
        })
      end
    end,
  },
  {
    "huggingface/llm.nvim",
    opts = {
      lsp = {
        bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
      },
      backend = "ollama",
      model = "deepseek-coder-v2",
      url = "http://localhost:11434",
    },
  },
}
