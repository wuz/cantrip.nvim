return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "j-hui/fidget.nvim",
    },
    -- "onsails/lspkind-nvim",
    -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    --     {
    --       "folke/neodev.nvim",
    --       config = function()
    --         require("neodev").setup({
    --           library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
    --         })
    --       end,
    --     },
    opts = function()
      local lspconfig = require("lspconfig")
      return {
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
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = false,
        },
        -- add any global capabilities here
        capabilities = {},
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          tailwindcss = {
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                    { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^'\"]*)(?:'|\"|`)" },
                  },
                },
              },
            },
          },
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
            root_dir = lspconfig.util.root_pattern(
              ".eslintrc.json",
              "eslint.config.mjs",
              "eslint.config.js",
              "eslint.config.cjs",
              ".eslintrc.js"
            ),
          },
          lua_ls = {
            ---@type LazyKeysSpec[]
            -- keys = {},
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
      }
    end,
    config = function(_, opts)
      local fidget = require("fidget")
      local config = require("cantrip").getConfig()
      local servers = vim.tbl_deep_extend("force", opts.servers, config.lsp.servers or {})
      local setup_fns = vim.tbl_deep_extend("force", opts.setup, config.lsp.setup or {})
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

      require("cantrip.utils.on_attach")(function(client, buffer)
        fidget.notify("Attached to " .. client.name)
        require("cantrip.plugins.lsp.format").on_attach(client, buffer)
        require("cantrip.plugins.lsp.keymaps").on_attach(client, buffer)
      end)
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    dependencies = {
      "mfussenegger/nvim-dap",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "eslint-lsp",
        "json-lsp",
        "bash-language-server",
        -- "ruff-lsp",
        "tailwindcss-language-server",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(plugin, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
      require("mason-nvim-dap").setup({
        ensure_installed = { "stylua", "jq" },
        automatic_installation = true,
        handlers = {},
        automatic_setup = true,
      })
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   cmd = { "NullLsInstall", "NullLsUninstall", "NullLsLog", "NullLsInfo" },
  --   dependencies = { "mason.nvim" },
  -- },
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   dependencies = {
  --     "mason.nvim",
  --     "none-ls.nvim",
  --   },
  --   build = ":MasonUpdate",
  --   opts = function()
  --     local null_ls = require("null-ls")
  --     return {
  --       ensure_installed = {
  --         "rubocop",
  --         "stylua",
  --         "write_good",
  --         "rubocop",
  --         "stylelint",
  --         -- "eslint_d",
  --         "statix",
  --         "nixfmt",
  --         "markdownlint",
  --         "shellharden",
  --         "shfmt",
  --         "gitrebase",
  --       },
  --       handlers = {
  --         function(source_name, methods)
  --           require("mason-null-ls.automatic_setup")(source_name, methods)
  --         end,
  --         reek = function(source_name, methods)
  --           local reek = require("cantrip.plugins.lsp.formatters.reek")
  --           null_ls.register(reek)
  --         end,
  --         -- eslint_d = function()
  --         --   null_ls.register({
  --         --     null_ls.builtins.diagnostics.eslint_d,
  --         --   })
  --         -- end,
  --         statix = function()
  --           null_ls.register({
  --             null_ls.builtins.code_actions.statix,
  --             null_ls.builtins.diagnostics.statix,
  --           })
  --         end,
  --       },
  --     }
  --   end,
  -- },
  {
    "stevearc/conform.nvim",
    dependencies = {
      "mason.nvim",
    },
    lazy = true,

    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = function()
      local plugin = require("lazy.core.config").plugins["conform.nvim"]
      ---@class ConformOpts
      local opts = {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        format = {
          timeout_ms = 3000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 3000,
          lsp_fallback = true,
        },
        ---@type table<string, conform.FormatterUnit[]>
        formatters_by_ft = {
          lua = { { "stylua" } },
          fish = { { "fish_indent" } },
          sh = { { "shfmt" } },
          javascript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          graphql = { { "prettierd", "prettier" } },
        },
        -- The options you set here will be merged with the builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
          injected = { options = { ignore_errors = true } },
          -- # Example of using dprint only when a dprint.json file is present
          -- dprint = {
          --   condition = function(ctx)
          --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          --   end,
          -- },
          --
          -- # Example of using shfmt with extra args
          -- shfmt = {
          --   prepend_args = { "-i", "2", "-ci" },
          -- },
        },
      }
      return opts
    end,
    config = function(_, opts)
      require("conform").setup(opts)
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,

    -- opts = {
    --   formatters_by_ft = {
    --   },
    --   format_on_save = {
    --     lsp_fallback = true,
    --     timeout_ms = 2000,
    --   },
    -- },
  },
  { "tami5/lspsaga.nvim", dependencies = "nvim-lspconfig" },
  { "nvim-lua/lsp-status.nvim", dependencies = "nvim-lspconfig" },
  { "ray-x/lsp_signature.nvim", dependencies = "nvim-lspconfig" },
  { "simrat39/symbols-outline.nvim", dependencies = "nvim-lspconfig" },
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
}
