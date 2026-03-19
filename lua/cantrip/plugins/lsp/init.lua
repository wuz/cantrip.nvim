local Cantrip = require("cantrip.utils")

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      -- { "mason-org/mason-lspconfig.nvim", opts = {}, config = function() end },
      -- { "nvim-lua/lsp-status.nvim" },
      { "j-hui/fidget.nvim" },
    },
    opts_extend = { "servers.*.keys" },
    opts = function(_, opts)
      ---@class PluginLspOpts
      local options = {
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
          enabled = true,
          exclude = { "vue" },
        },
        codelens = {
          enabled = true,
        },
        folds = {
          enabled = true,
        },
        -- LSP Server Settings
        -- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
        ---@alias lazyvim.lsp.Config vim.lsp.Config
        ---@type table<string, lazyvim.lsp.Config|boolean>
        servers = {
          -- configuration for all lsp servers
          ["*"] = {
            capabilities = {
              workspace = {
                fileOperations = {
                  didRename = true,
                  willRename = true,
                },
              },
            },
            --   vim.diagnostic.open_float({
            --     border = "single",
            --     width = 80,
            --   })
            -- stylua: ignore
            keys = {
              { "<leader>cl", function() Snacks.picker.lsp_config() end,          desc = "Lsp Info" },
              { "gd",         vim.lsp.buf.definition,                             desc = "Goto Definition",            has = "definition" },
              { "gr",         vim.lsp.buf.references,                             desc = "References",                 nowait = true },
              { "gI",         vim.lsp.buf.implementation,                         desc = "Goto Implementation" },
              { "gy",         vim.lsp.buf.type_definition,                        desc = "Goto T[y]pe Definition" },
              { "gD",         vim.lsp.buf.declaration,                            desc = "Goto Declaration" },
              { "K",          function() return vim.lsp.buf.hover() end,          desc = "Hover" },
              { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "Signature Help",             has = "signatureHelp" },
              { "<c-k>",      function() return vim.lsp.buf.signature_help() end, mode = "i",                          desc = "Signature Help", has = "signatureHelp" },
              { "<leader>ca", vim.lsp.buf.code_action,                            desc = "Code Action",                mode = { "n", "x" },     has = "codeAction" },
              { "<leader>cc", vim.lsp.codelens.run,                               desc = "Run Codelens",               mode = { "n", "x" },     has = "codeLens" },
              { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "Refresh & Display Codelens", mode = { "n" },          has = "codeLens" },
              { "<leader>cR", function() Snacks.rename.rename_file() end,         desc = "Rename File",                mode = { "n" },          has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
              { "<leader>cr", vim.lsp.buf.rename,                                 desc = "Rename",                     has = "rename" },
              {
                "<leader>cA",
                function()
                  vim.lsp.buf.code_action({
                    apply = true,
                    context = {
                      only = { "source" },
                      diagnostics = {},
                    },
                  })
                end,
                desc = "Source Action",
                has = "codeAction"
              },
              {
                "]]",
                function() Snacks.words.jump(vim.v.count1) end,
                has = "documentHighlight",
                desc = "Next Reference",
                enabled = function() return Snacks.words.is_enabled() end
              },
              {
                "[[",
                function() Snacks.words.jump(-vim.v.count1) end,
                has = "documentHighlight",
                desc = "Prev Reference",
                enabled = function() return Snacks.words.is_enabled() end
              },
              {
                "<a-n>",
                function() Snacks.words.jump(vim.v.count1, true) end,
                has = "documentHighlight",
                desc = "Next Reference",
                enabled = function() return Snacks.words.is_enabled() end
              },
              {
                "<a-p>",
                function() Snacks.words.jump(-vim.v.count1, true) end,
                has = "documentHighlight",
                desc = "Prev Reference",
                enabled = function() return Snacks.words.is_enabled() end
              },
            },
          },
        },
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return options
    end,
    config = vim.schedule_wrap(function(_, opts)
      local fidget = require("fidget")

      require("cantrip.plugins.lsp.format").setup()
      -- setup keymaps
      for server, server_opts in pairs(opts.servers) do
        if type(server_opts) == "table" and server_opts.keys then
          require("cantrip.plugins.lsp.keymaps").set({ name = server ~= "*" and server or nil }, server_opts.keys)
        end
      end

      -- inlay hints
      if opts.inlay_hints.enabled then
        Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      -- folds
      -- if opts.folds.enabled then
      --   Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
      --     if LazyVim.set_default("foldmethod", "expr") then
      --       LazyVim.set_default("foldexpr", "v:lua.vim.lsp.foldexpr()")
      --     end
      --   end)
      -- end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
          vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = buffer,
            callback = function()
              vim.lsp.codelens.enable(true, { bufnr = buffer })
            end,
          })
        end)
      end

      -- override diagnostic icons
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
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

      if opts.servers["*"] then
        vim.lsp.config("*", opts.servers["*"])
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason = Cantrip.has("mason-lspconfig.nvim")
      local mason_all = have_mason
          and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
        or {} --[[ @as string[] ]]
      local mason_exclude = {} ---@type string[]

      ---@return boolean? exclude automatic setup
      local function configure(server)
        if server == "*" then
          return false
        end
        fidget.notify("Attached to " .. server)
        local sopts = opts.servers[server]
        sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts --[[@as lazyvim.lsp.Config]]

        if sopts.enabled == false then
          mason_exclude[#mason_exclude + 1] = server
          return
        end

        local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, sopts) then
          mason_exclude[#mason_exclude + 1] = server
        else
          vim.lsp.config(server, sopts) -- configure the server
          if not use_mason then
            vim.lsp.enable(server)
          end
        end
        return use_mason
      end

      local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
      if have_mason then
        require("mason-lspconfig").setup({
          ensure_installed = vim.list_extend(install, Cantrip.opts("mason-lspconfig.nvim").ensure_installed or {}),
          automatic_enable = { exclude = mason_exclude },
        })
      end
    end),
  },
  { import = "cantrip.plugins.lsp.conform" },
  { import = "cantrip.plugins.lsp.lint" },
  { import = "cantrip.plugins.lsp.mason" },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "dnlhc/glance.nvim",
        cmd = "Glance",
      },
    },
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "gD", "<cmd>Glance definitions<cr>", desc = "Glance Definition", has = "definition" },
            { "gR", "<cmd>Glance references<cr>", desc = "Glance References", nowait = true },
            { "gM", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
            { "gY", "<cmd>Glance type_definitions<cr>", desc = "Goto T[y]pe Definition" },
          },
        },
      },
    },
  },
}
