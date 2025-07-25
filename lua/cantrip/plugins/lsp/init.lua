local Cantrip = require("cantrip.utils")

return {
  { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      { "mason-org/mason-lspconfig.nvim", config = function() end },
      "j-hui/fidget.nvim",
      "saecki/live-rename.nvim",
      { "onsails/lspkind-nvim" },
      -- -- extra lsp tools
      { "tami5/lspsaga.nvim", dependencies = "nvim-lspconfig" },
      { "nvim-lua/lsp-status.nvim", dependencies = "nvim-lspconfig" },
      { "ray-x/lsp_signature.nvim", dependencies = "nvim-lspconfig" },
      {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
          { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        config = true,
      },
    },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          -- prefix = "●",
          prefix = "icons",
        },
        severity_sort = true,
        float = {
          header = "",
          source = true,
          border = "solid",
          focusable = true,
        },
      },
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = false,
      },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      servers = {},
      setup = {},
    },
    config = function(_, opts)
      local fidget = require("fidget")
      local config = require("cantrip").getConfig()
      local servers = vim.tbl_deep_extend("force", opts.servers, config.lsp.servers or {})
      local setup_fns = vim.tbl_deep_extend("force", opts.setup, config.lsp.setup or {})
      local cmp_present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local blink_present, blink = pcall(require, "blink.cmp")

      -- diagnostics signs
      if vim.fn.has("nvim-0.10.0") == 0 then
        if type(opts.diagnostics.signs) ~= "boolean" then
          for severity, icon in pairs(opts.diagnostics.signs.text) do
            local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
          end
        end
      end

      if vim.fn.has("nvim-0.10") == 1 then
        -- inlay hints
        if opts.inlay_hints.enabled and client:supports_method("textDocument/inlayHint") then
          vim.lsp.handlers["textDocument/inlayHint"] = function(client, buffer)
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end
        end
      end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens and client:supports_method("textDocument/codeLens") then
        vim.lsp.handlers["textDocument/codeLens"] = function(client, buffer)
          vim.lsp.codelens.refresh()
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
        end
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = {
              Error = " ",
              Warn = " ",
              Hint = " ",
              Info = " ",
            }
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

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
        require("cantrip.plugins.lsp.format").on_attach(client, buffer)
        require("cantrip.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      local capabilities = {}

      if cmp_present then
        capabilities = cmp_nvim_lsp.default_capabilities()
      elseif blink_present then
        capabilities = blink.get_lsp_capabilities()
      else
        capabilities = vim.lsp.protocol.make_client_capabilities()
      end

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

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
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig").get_mappings().lspconfig_to_package)
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
        mlsp.setup { ensure_installed = ensure_installed, handlers = { setup } }
      end

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "solid",
      })
    end,
  },
  { import = "cantrip.plugins.lsp.conform" },
  { import = "cantrip.plugins.lsp.lint" },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "dnlhc/glance.nvim",
        cmd = "Glance",
      },
    },
    opts = function()
      local Keys = require("cantrip.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gD", "<cmd>Glance definitions<cr>",      desc = "Glance Definition",     has = "definition" },
        { "gR", "<cmd>Glance references<cr>",       desc = "Glance References",     nowait = true },
        { "gM", "<cmd>Glance implementations<cr>",  desc = "Glance implementations" },
        { "gY", "<cmd>Glance type_definitions<cr>", desc = "Goto T[y]pe Definition" },
      })
    end,
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- optional picker via fzf-lua
      { "ibhagwan/fzf-lua" },
    },
    event = "LspAttach",
    opts = {
      picker = "buffer",
    },
  },
}
