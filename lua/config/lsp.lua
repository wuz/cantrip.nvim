local nvim_lsp = require"lspconfig"
local lsp_installer = require"nvim-lsp-installer"
local saga = require"lspsaga"
local lsp_status = require"lsp-status"
local lsp_signature = require"lsp_signature"
local lspkind = require"lspkind"
local notify = require"notify";

local fn = vim.fn
local cmd = vim.cmd
local lsp = vim.lsp
local buf_keymap = vim.api.nvim_buf_set_keymap
local util = lsp.util

local autocmd = require"utils.autocmd"
local map = require "utils".map

local kind_symbols = {
  Text = "",
  Method = "Ƒ",
  Function = "ƒ",
  Constructor = "",
  Variable = "",
  Class = "",
  Interface = "ﰮ",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "了",
  Keyword = "",
  Snippet = "﬌",
  Color = "",
  File = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = ""
}

local function select_client(method)
  local clients = vim.tbl_values(vim.lsp.buf_get_clients())
  clients =
    vim.tbl_filter(
    function(client)
      return client.supports_method(method)
    end,
    clients
  )

  for i = 1, #clients do
    if  clients[i].name == "null-ls" then
      return clients[i]
    end
  end

  return nil
end


local format_async = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
    notify("vim.lsp.buf.formatting_sync: ")
    notify(err)
    return
  end
  if not vim.api.nvim_buf_get_option(bufnr, "modified") then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)
    if bufnr == vim.api.nvim_get_current_buf() then
      vim.api.nvim_command("noautocmd :update")
    end
  end
end

vim.lsp.handlers["textDocument/formatting"] = format_async
vim.lsp.handlers["documentFormatting"] = format_async

function formatting_sync(options, timeout_ms)
  local client = select_client("documentFormatting") or select_client("textDocument/formatting")
  if client == nil then
    return
  end

  notify("Formatting with ".. client.name)

  local params = util.make_formatting_params(options)
  local bufnr= vim.api.nvim_get_current_buf()
  local result, err = client.request_sync("textDocument/formatting", params, timeout_ms, bufnr)
  format_async(err, nil, result, nil,bufnr);
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
  local config = {
    -- your config
    underline = true,
    virtual_text = {
      prefix = "■ ",
      spacing = 4
    },
    signs = true,
    update_in_insert = false
  }
  local uri = params.uri
  local bufnr = vim.uri_to_bufnr(uri)

  if not bufnr then
    return
  end

  local diagnostics = params.diagnostics

  for i, v in ipairs(diagnostics) do
    diagnostics[i].message = string.format("%s: %s", v.source, v.message)
  end

  vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return
  end

  vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
end


_G.lsp_organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

local map_keys = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Mappings.
  local opts = {noremap = true, silent = true}
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gr", "kcmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>l", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)


  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<Leader>G", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<Leader>G", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  else
    buf_set_keymap("n", "<leader>G", "<cmd>lua formatting_sync()<cr>", opts)
  end

  autocmd("FormatAutogroup", "BufWritePre <buffer> lua formatting_sync()")

end


-- a custom attach function to handle default functionality
local on_attach = function(client, bufnr)
  notify("Attached to " .. client.name)

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  map_keys(client, bufnr)

  lsp_status.on_attach(client)
end

local server_settings = {
  clangd = {
    cmd = {
      "clangd", -- '--background-index',
      "--clang-tidy",
      "--completion-style=bundled",
      "--header-insertion=iwyu",
      "--suggest-missing-includes",
      "--cross-file-rename"
    },
    handlers = lsp_status.extensions.clangd.setup(),
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true
    }
  },
  cssls = {
    filetypes = {"css", "scss", "less", "sass"},
    root_dir = nvim_lsp.util.root_pattern("package.json", ".git")
  },
  dockerls = {
    cmd = {"docker-langserver", "--stdio"},
    root_dir = nvim_lsp.util.root_pattern("Dockerfile*", ".git")
  },
  graphql = {
    filetypes = {"graphql", "js", "ts", "tsx", "jsx"}
  },
  jsonls = {cmd = {"json-languageserver", "--stdio"}},
  julials = {settings = {julia = {format = {indent = 2}}}},
  pyright = {settings = {python = {formatting = {provider = "yapf"}}}},
  solargraph = {
    cmd = {"bundle exec solargraph", "stdio"},
  },
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
            globals = {'vim'},
        },
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";")
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
            enable = false,
        },
      }
    }
  },
  tsserver = {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
      on_attach(client)
    end
  },
}


lspkind.init {symbol_map = kind_symbols}

lsp_status.config {
  kind_labels = kind_symbols,
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[1])},
        ["end"] = {character = 0, line = vim.fn.byte2line(symbol.valueRange[2])}
      }

      return require("lsp-status/util").in_range(cursor_pos, value_range)
    end
  end
}

lsp_status.register_progress()

lsp_installer.settings {
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
}

local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
    }

    if server_settings[server.name] then
      vim.tbl_deep_extend("keep", opts, server_settings[server.name])
    end

    opts.capabilities = vim.tbl_deep_extend(
      "keep",
      opts.capabilities or {},
      cmp_capabilities,
      lsp_status.capabilities or {}
    )

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

nvim_lsp["null-ls"].setup({
    on_attach = on_attach
})

saga.init_lsp_saga()
lsp_signature.setup()

local signs = {Error = " ", Warning = " ", Hint = " ", Information = " "}

local sign_define = vim.fn.sign_define
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end

--[[
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = true,
  position = "right",
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = {
    close = "<Esc>",
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    rename_symbol = "r",
    code_actions = "a"
  },
  lsp_blacklist = {}
}
]]--
