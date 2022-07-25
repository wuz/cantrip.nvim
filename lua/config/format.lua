local null_ls = require("null-ls")
require("config.formatters.reek")

local sources = {
  null_ls.builtins.formatting.json_tool,
  null_ls.builtins.formatting.fixjson,
  null_ls.builtins.formatting.eslint_d,
  null_ls.builtins.diagnostics.eslint_d,
  -- null_ls.builtins.code_actions.eslint_d,
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.diagnostics.rubocop,
  null_ls.builtins.diagnostics.stylelint,
  null_ls.builtins.code_actions.statix,
  null_ls.builtins.formatting.nixfmt,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.markdownlint,
  null_ls.builtins.diagnostics.write_good,
  null_ls.builtins.formatting.shellharden,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.code_actions.gitrebase,
}

null_ls.setup({ sources = sources })
