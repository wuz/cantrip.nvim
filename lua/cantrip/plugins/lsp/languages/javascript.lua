return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "eslint-lsp",
          "typescript-language-server",
          "prettierd",
          "vtsls",
        })
      end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    cmd = { "DapInstall", "DapUninstall" },
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "js",
        })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      "williamboman/mason.nvim",
    },
    opts = {
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        tsserver = {},
        vtsls = {},
        eslint = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
          end,
          settings = {
            enable = true,
            format = { enable = true }, -- this will enable formatting
            packageManager = "npm",
            autoFixOnSave = true,
            lintTask = {
              enable = true,
            },
            experimental = { useFlatConfig = false },
            validate = "on",
            codeActionOnSave = {
              enable = false,
              mode = "all",
            },
            quiet = false,
            onIgnoredFiles = "off",
            run = "onType",
            workingDirectory = { mode = "location" },
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = "separateLine",
              },
              showDocumentation = {
                enable = true,
              },
            },
          },
          root_dir = require("lspconfig").util.root_pattern(
            ".eslintrc.json",
            "eslint.config.mjs",
            "eslint.config.js",
            "eslint.config.cjs",
            ".eslintrc.js"
          ),
        },
      },
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        eslint = function()
          if not pcall(require, "vim.lsp._dynamic") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
              command = "silent! EslintFixAll",
              group = vim.api.nvim_create_augroup("EslintFixAll", {}),
            })
          end
        end,
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      debugger_cmd = { "js-debug-adapter" },
      adapters = { "pwa-node" },
    },
    config = function(_, opts)
      require("dap-vscode-js").setup(opts)
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
        ["neotest-jest"] = {},
      },
    },
  },
}
