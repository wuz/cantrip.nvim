local Cantrip = require("cantrip.utils")
return {
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    init = function()
      vim.g.navic_silence = true
      Cantrip.lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/documentSymbol") then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    config = true,
  },
  { "onsails/lspkind-nvim" },
  -- { "folke/neoconf.nvim",  cmd = "Neoconf", config = true },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        float = {
          header = "",
          source = true,
          border = "solid",
          focusable = true,
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      servers = {
        yamlls = {},
        gopls = {},
      },
      setup = {},
    },
    config = function(_, opts)
      local fidget = require("fidget")
      local config = require("cantrip").getConfig()
      local servers = vim.tbl_deep_extend("force", opts.servers, config.lsp.servers or {})
      local setup_fns = vim.tbl_deep_extend("force", opts.setup, config.lsp.setup or {})
      local lsp_status = require("lsp-status")

      lsp_status.register_progress()

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("cantrip.plugins.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      Cantrip.lsp.on_attach(function(client, buffer)
        fidget.notify("Attached to " .. client.name)
        lsp_status.on_attach(client)
        require("cantrip.plugins.lsp.format").on_attach(client, buffer)
        require("cantrip.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {}, lsp_status.capabilities)

        if setup_fns[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif setup_fns["*"] then
          if setup_fns["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end
      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end
      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --   border = "solid",
      -- })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "solid",
      })
    end,
  },
  -- -- extra lsp tools
  { "tami5/lspsaga.nvim", dependencies = "nvim-lspconfig" },
  { "nvim-lua/lsp-status.nvim", dependencies = "nvim-lspconfig" },
  { "ray-x/lsp_signature.nvim", dependencies = "nvim-lspconfig" },
  { "simrat39/symbols-outline.nvim", dependencies = "nvim-lspconfig" },
  -- -- lsp-based formatters
  { import = "cantrip.plugins.lsp.conform" },
  { import = "cantrip.plugins.lsp.lint" },
}
