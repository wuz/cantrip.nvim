local map = require "utils".map
local autocmd = require "utils.autocmd"

local function prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

-- local function rufo()
--   return {
--     exe = "bundle exec rufo",
--     args = {},
--     stdin = true
--   }
-- end

local function rubocop()
  return {
    exe = "bundle exec rubocop",
    args = {
      "-a",
      "--stdin",
      vim.api.nvim_buf_get_name(0),
      "--stderr",
      "--disable-uncorrectable",
      "-f quiet",
      "-C true",
      "--no-color"
    },
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

local filetypes = {
  javascript = {prettier},
  javascriptreact = {prettier},
  typescript = {prettier},
  typescriptreact = {prettier},
  json = {prettier},
  html = {prettier},
  scss = {prettier},
  css = {prettier},
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

require("formatter").setup(
  {
    logging = false,
    filetype = filetypes
  }
)

-- Keymap
map("n", "<leader>F", "<cmd>Format<cr>", silent)

autocmd("FormatAutogroup", "BufWritePost *.js,*.rs,*.lua,*.nix,*.json,*.ts,*.tsx,*.mdx,*.html,*.rb FormatWrite")
