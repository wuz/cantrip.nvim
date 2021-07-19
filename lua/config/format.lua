local map = require "utils".map
-- local nvim_lsp = require("lspconfig")

-- local filetypes = {
--   typescript = "eslint",
--   javascript = "eslint",
--   typescriptreact = "eslint",
--   javascriptreact = "eslint",
--   ruby = "rubocop"
-- }
--
-- local linters = {
--   eslint = {
--     sourceName = "eslint",
--     command = "eslint_d",
--     rootPatterns = {".eslintrc.js", "package.json"},
--     debounce = 100,
--     args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
--     parseJson = {
--       errorsRoot = "[0].messages",
--       line = "line",
--       column = "column",
--       endLine = "endLine",
--       endColumn = "endColumn",
--       message = "${message} [${ruleId}]",
--       security = "severity"
--     },
--     securities = {[2] = "error", [1] = "warning"}
--   },
--   rubocop = {
--     sourceName = "rubocop",
--     command = "rubocop",
--     rootPatterns = {".rubocop.yml", "Gemfile"},
--     debounce = 100,
--     args = {"--stdin", "%filepath", "--format", "json"},
--     parseJson = {
--       errorsRoot = "files.[0].offenses",
--       line = "location.line",
--       column = "location.column",
--       endLine = "endLine",
--       endColumn = "endColumn",
--       message = "${message} [${cop_name}]",
--       security = "severity"
--     },
--     -- securities = {[2] = "error", [1] = "warning"}
--     -- info, refactor, convention, warning, error and fatal
-- }
--
-- nvim_lsp.diagnosticls.setup = {
--     on_attach = on_attach,
--     init_options = {
--         filetypes = filetypes,
--         linters = linters,
--     }
-- }

local function prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

local function rufo()
  return {
    exe = "rufo",
    args = {},
    stdin = true
  }
end

local function rubocop()
  return {
    exe = "bundle exec rubocop -x",
    args = {"--stdin", vim.api.nvim_buf_get_name(0), "--stderr"},
    stdin = true,
    cwd = vim.fn.expand("%:p:h")
  }
end

local function nixfmt()
  return {
    exe = "nixfmt",
    args = {vim.api.nvim_buf_get_name(0)},
    stdin = false
  }
end

local function clangformat()
  return {exe = "clang-format", args = {"-assume-filename=" .. vim.fn.expand("%:t")}, stdin = true}
end

local function rustfmt()
  return {exe = "rustfmt", args = {"--emit=stdout"}, stdin = true}
end

local function lua_format()
  return {
    exe = "luafmt",
    args = {"--indent-count", 2, "--stdin"},
    stdin = true
  }
end

local function mdx_format()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote", "--parser", "mdx"},
    stdin = true
  }
end
local function yapf()
  return {exe = "yapf", stdin = true}
end
local function isort()
  return {exe = "isort", args = {"-", "--quiet"}, stdin = true}
end
local function latexindent()
  return {exe = "latexindent", args = {"-sl", "-g /dev/stderr", "2>/dev/null"}, stdin = true}
end

local format_async = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
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

require("formatter").setup(
  {
    logging = false,
    filetype = {
      javascript = {prettier},
      javascriptreact = {prettier},
      typescript = {prettier},
      typescriptreact = {prettier},
      json = {prettier},
      html = {prettier},
      ["markdown.mdx"] = {mdx_format},
      rust = {rustfmt},
      python = {isort, yapf},
      tex = {latexindent},
      c = {clangformat},
      cpp = {clangformat},
      lua = {lua_format},
      nix = {nixfmt},
      ruby = {rubocop}
    }
  }
)

-- Keymap
map("n", "<leader>F", "<cmd>Format<cr>", silent)

vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.rs,*.lua,*.nix,*.json,*.ts,*.tsx,*.mdx,*.html,*.rb FormatWrite
augroup END
]],
  true
)
