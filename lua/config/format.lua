local null_ls = require("null-ls")

local eslint_d = null_ls.builtins.formatting.eslint_d.with({
  root_dir = function(utils)
    return utils.root_pattern({ ".git" })
  end,
})

local sources = {
  null_ls.builtins.formatting.json_tool,
  null_ls.builtins.formatting.fixjson,
  eslint_d,
  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.diagnostics.stylelint,
  null_ls.builtins.code_actions.statix,
  null_ls.builtins.formatting.nixfmt,
  null_ls.builtins.diagnostics.selene,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.markdownlint,
  null_ls.builtins.diagnostics.write_good,
  null_ls.builtins.formatting.shellharden,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({ sources = sources })
