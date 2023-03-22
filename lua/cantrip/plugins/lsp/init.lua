return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      {
        "folke/neodev.nvim",
        config = function()
          require("neodev").setup({
            library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
          })
        end,
      },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        tsserver = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      setup = {},
    },
    config = function(_, opts)
      local notify = require("notify")
      local config = require("cantrip").getConfig()
      local servers = vim.tbl_deep_extend("force", opts.servers, config.lsp.servers or {})
      local setup_fns = vim.tbl_deep_extend("force", opts.setup, config.lsp.servers or {})
      require("cantrip.utils.on_attach")(function(client, buffer)
        notify("Attached to " .. client.name)
        require("cantrip.plugins.lsp.format").on_attach(client, buffer)
        require("cantrip.plugins.lsp.keymaps").on_attach(client, buffer)
      end)
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if setup_fns[server] then
          if setup_fns[server](server, server_opts) then
            return
          end
        elseif setup_fns["*"] then
          if setup_fns["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end
      local mappings = require("mason-lspconfig.mappings.server")
      -- temp fix for lspconfig rename
      -- https://github.com/neovim/nvim-lspconfig/pull/2439
      if not mappings.lspconfig_to_package.lua_ls then
        mappings.lspconfig_to_package.lua_ls = "lua-language-server"
        mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
      end

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()
      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end
      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })
    end,
  },
  {

    "williamboman/mason.nvim",
    cmd = "Mason",
    dependencies = { "jay-babu/mason-null-ls.nvim", "jay-babu/mason-nvim-dap.nvim" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "eslint-lsp",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(plugin, opts)
      local null_ls = require("null-ls")
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
      require("mason-null-ls").setup({
        ensure_installed = {
          "json_tool",
          "jq",
          "fixjson",
          "rubocop",
          "stylua",
          "write_good",
          "rubocop",
          "stylelint",
          "statix",
          "nixfmt",
          "markdownlint",
          "shellharden",
          "shfmt",
          "shellcheck",
          "gitsigns",
          "gitrebase",
        },
        automatic_installation = true,
        automatic_setup = true,
      })
      require("mason-null-ls").setup_handlers({
        function(source_name, methods)
          -- all sources with no handler get passed here

          -- To keep the original functionality of `automatic_setup = true`,
          -- please add the below.
          require("mason-null-ls.automatic_setup")(source_name, methods)
        end,
        reek = function(source_name, methods)
          local reek = require("cantrip.plugins.lsp.formatters.reek")
          null_ls.register(reek)
        end,
        statix = function()
          null_ls.register({
            null_ls.builtins.code_actions.statix,
            null_ls.builtins.diagnostics.statix,
          })
        end,
      })
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        automatic_setup = true,
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- null_ls.builtins.formatting.json_tool,
          -- null_ls.builtins.formatting.fixjson,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.diagnostics.stylelint,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.write_good,
          null_ls.builtins.formatting.shellharden,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.gitrebase,
        },
      }
    end,
  },
  { "onsails/lspkind-nvim" },
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
  { "tami5/lspsaga.nvim", after = "nvim-lspconfig" },
  { "nvim-lua/lsp-status.nvim", after = "nvim-lspconfig" },
  { "ray-x/lsp_signature.nvim", after = "nvim-lspconfig" },
  { "simrat39/symbols-outline.nvim", after = "nvim-lspconfig" },
  {
    "kosayoda/nvim-lightbulb",
    init = function()
      vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
    end,
    opt = {

      ignore = { "null-ls" },
      sign = {
        enabled = true,
      },
    },
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)" },
    },
  },
  {
    "j-hui/fidget.nvim",
  },
}
