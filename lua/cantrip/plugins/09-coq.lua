return {
  {
    enabled = false,
    "ms-jpq/coq_nvim",
    branch = "coq",
    event = "InsertEnter",
    dependencies = {
      { "ms-jpq/coq.artifacts", branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
    build = ":COQdeps",
    init = function()
      vim.g.coq_settings = vim.g.coq_settings or {}
      vim.g.coq_settings = vim.tbl_deep_extend("force", vim.g.coq_settings, {
        auto_start = "shut-up",
        keymap = {
          recommended = true,
          manual_complete = "<C-Space>",
          bigger_preview = "<C-S-i>",
          jump_to_mark = "<C-S-y>",
        },
        clients = {
          lsp = {
            enabled = true,
            --resolve_timeout = 2,
            weight_adjust = 1.75,
          },
          tree_sitter = {
            enabled = true,
            weight_adjust = 1.5,
          },
          buffers = { match_syms = true },
          tmux = { match_syms = false },
          paths = { preview_lines = 8 },
        },
      })
    end,
    config = function()
      require("coq_3p") {
        { src = "nvimlua", short_name = "nLUA", conf_only = false }, -- Lua
      }
    end,
  },
}
