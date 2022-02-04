local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

local cond = require("nvim-autopairs.conds")

npairs.setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "vim" },
  fast_wrape = {},
  ts_config = {
    lua = { "string" }, -- it will not add a pair on that treesitter node
    java = false,
    javascript = { "string", "template_string" },
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

local ts_conds = require("nvim-autopairs.ts-conds")

-- press % => %% is only inside comment or string
npairs.add_rules({
  Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})
