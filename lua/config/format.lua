local null_ls = require("null-ls")

-- local format = {
--   filetypes = {},
--   languages = {}
-- }
-- 
-- local function createCommand(command, args_table)
--   return command .. " " .. table.concat(args_table, " ")
-- end
-- 
-- local programs = {
--   prettier = {
--     formatCommand = createCommand("prettier", {"--stdin-filepath", "${INPUT}"}),
--     formatStdin = true
--   },
--   eslint = {
--     lintStdin = true,
--     lintFormats = {
--       "%f(%l,%c): %tarning %m",
--       "%f(%l,%c): %rror %m"
--     },
--     lintIgnoreExitCode = true,
--     lintCommand = createCommand("eslint_d", {"-f unix", "--stdin","--stdin-filename", "${INPUT}", "-f visualstudio"}),
--     formatCommand = createCommand("eslint_d", {"--fix-to-stdout", "--stdin","--stdin-filename", "${INPUT}"}),
--     formatStdin = true,
--   },
--   -- rufo =
--   --   return {
--   --     formatCommand = "bundle formatCommandc rufo",
--   --     args = {},
--   --     formatStdin = true
--   --   },
-- 
--   rubocop = {
--     formatCommand = createCommand(
--       "bundle exec rubocop",
--       {
--         "-a",
--         "--stdin",
--         "${INPUT}",
--         "--stderr",
--         "-f quiet",
--         "-C true",
--         "--no-color"
--       }
--     ),
--     formatStdin = true
--   },
--   nixfmt = {
--     formatCommand = createCommand("nixfmt", {"${INPUT}"}),
--     formatStdin = false
--   },
--   clangformat = {
--     formatCommand = createCommand("clang-format", {"-assume-filename=" .. vim.fn.expand("%:t")})
--   },
--   rustfmt = {
--     formatCommand = createCommand("rustfmt", {"--emit=stdout"}), 
--     formatStdin = true
--   },
--   lua_format = {
--     formatCommand = createCommand("luafmt", {"--indent-count", 2, "--stdin"}),
--     formatStdin = true
--   },
--   mdx_format = {
--     formatCommand = createCommand(
--       "prettier",
--       {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote", "--parser", "mdx"}
--     ),
--     formatStdin = true
--   },
--   yapf = {
--     formatCommand = "yapf", 
--     formatStdin = true
--   },
--   isort = {
--     formatCommand = createCommand("isort", {"-", "--quiet"}), 
--     formatStdin = true
--   },
--   latexindent = {
--     formatCommand = createCommand("latexindent", {"-sl", "-g /dev/stderr", "2>/dev/null"}),
--     formatStdin = true
--   }
-- }
-- 
-- 
-- -- vim.lsp.handlers["textDocument/formatting"] = format_async
-- 
-- -- require("formatter").setup(
-- --   {
-- --     logging = false,
-- --     filetype = filetypes
-- --   }
-- -- )
-- --
-- 
-- local languages = {
--       javascript = {
--         programs.prettier,
--         programs.eslint
--       },
--       javascriptreact = {
--         programs.prettier,
--         programs.eslint
--       },
--       typescript = {
--         programs.prettier,
--         programs.eslint
--       },
--       typescriptreact = {
--         programs.prettier,
--         programs.eslint
--       },
--       json = {
--         programs.prettier
--       },
--       html = {
--         programs.prettier
--       },
--       scss = {
--         programs.prettier
--       },
--       css = {
--         programs.prettier
--       },
--       ["markdown.mdx"] = {
--         programs.mdx_format
--       },
--       markdown = {
--         programs.mdx_format
--       },
--       rust = {
--         programs.rustfmt
--       },
--       python = {
--         programs.isort, 
--         programs.yapf
--       },
--       tex = {
--         programs.latexindent
--       },
--       c = {
--         programs.clangformat
--       },
--       cpp = {
--         programs.clangformat
--       },
--       lua = {
--         programs.lua_format
--       },
--       nix = {
--         programs.nixfmt
--       },
--       ruby = {
--         programs.rubocop
--       }
--   }
-- 
-- local filetypes = {}
-- 
-- for language, _ in pairs(languages) do
--   table.insert(filetypes , language)
-- end
-- 
-- format.languages = languages
-- format.filetypes = filetypes

local sources = {
    null_ls.builtins.formatting.json_tool,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.code_actions.statix,
    null_ls.builtins.formatting.nixfmt,
    null_ls.builtins.diagnostics.selene,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.lua_format,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.code_actions.gitsigns,
}

null_ls.config({
    sources = sources
})



