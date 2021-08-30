local lspconfig = require("lspconfig")
local lsp_status = require("lsp-status")
local lspkind = require("lspkind")

local fn = vim.fn
local cmd = vim.cmd
local lsp = vim.lsp
local buf_keymap = vim.api.nvim_buf_set_keymap

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

local signs = {Error = " ", Warning = " ", Hint = " ", Information = " "}

local sign_define = vim.fn.sign_define
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end

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
  end,
  current_function = false
}

lsp_status.register_progress()
lspkind.init {symbol_map = kind_symbols}

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

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

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
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = {
  bashls = {},
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
    root_dir = lspconfig.util.root_pattern("package.json", ".git")
  },
  graphql = {
    filetypes = {"graphql", "js", "ts", "tsx", "jsx"}
  },
  ghcide = {},
  html = {},
  jsonls = {cmd = {"json-languageserver", "--stdio"}},
  julials = {settings = {julia = {format = {indent = 2}}}},
  ocamllsp = {},
  pyright = {settings = {python = {formatting = {provider = "yapf"}}}},
  rust_analyzer = {},
  solargraph = {},
  sumneko_lua = {
    cmd = {"lua-language-server"},
    settings = {
      Lua = {
        diagnostics = {globals = {"vim"}},
        runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
          }
        }
      }
    }
  },
  texlab = {
    settings = {
      latex = {forwardSearch = {executable = "okular", args = {"--unique", "file:%p#src:%l%f"}}}
    },
    commands = {
      TexlabForwardSearch = {
        function()
          local pos = vim.api.nvim_win_get_cursor(0)
          local params = {
            textDocument = {uri = vim.uri_from_bufnr(0)},
            position = {line = pos[1] - 1, character = pos[2]}
          }
          lsp.buf_request(
            0,
            "textDocument/forwardSearch",
            params,
            function(err, _, _, _)
              if err then
                error(tostring(err))
              end
            end
          )
        end,
        description = "Run synctex forward search"
      }
    }
  },
  tsserver = {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end
  },
  vimls = {}
}

local snippet_capabilities = {
  textDocument = {completion = {completionItem = {snippetSupport = true}}}
}

for server, config in pairs(servers) do
  config.on_attach = on_attach
  config.capabilities =
    vim.tbl_deep_extend("keep", config.capabilities or {}, lsp_status.capabilities, snippet_capabilities)
  lspconfig[server].setup(config)
end

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
