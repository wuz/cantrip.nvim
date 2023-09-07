return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
      servers = {
        -- tsserver = {},
        vtsls = {},
      },
      setup = {
        --   tsserver = function(_, opts)
        --     require("cantrip.utils.on_attach")(function(client, buffer)
        --       if client.name == "tsserver" then
        --         -- stylua: ignore
        --         vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
        --         vim.keymap.set(
        --           "n",
        --           "<leader>cR",
        --           "<cmd>TypescriptRenameFile<CR>",
        --           { desc = "Rename File", buffer = buffer }
        --         )
        --       end
        --     end)
        --     require("typescript").setup({ server = opts })
        --     return true
        --   end,
      },
    },
  },
}
