--@param config {args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

-- Merge all plugin tables from individual files
local function merge_plugins(...)
  local result = {}
  for i = 1, select("#", ...) do
    local plugins = select(i, ...)
    if plugins then
      for _, plugin in ipairs(plugins) do
        table.insert(result, plugin)
      end
    end
  end
  return result
end

local core_plugins = {
  -- Plugin manager
  { "folke/lazy.nvim", version = false },
  -- Load cantrip as a plugin
  {
    "wuz/cantrip.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    config = true,
  },
  -- Lua utils
  { "nvim-lua/plenary.nvim" },
  { "tpope/vim-repeat", event = "VeryLazy" },
  -- UI Utilities
  { "MunifTanjim/nui.nvim" },
}

return merge_plugins(
  core_plugins,

  require("cantrip.plugins.core.snacks"),
  -- better luals for neovim development
  require("cantrip.plugins.core.lazydev"),
  require("cantrip.plugins.core.completion"),
  require("cantrip.plugins.core.treesitter"),
  require("cantrip.plugins.core.builtins"),
  require("cantrip.plugins.core.mini-icons"),
  require("cantrip.plugins.core.fidget"),

  require("cantrip.plugins.ui.trouble"),
  require("cantrip.plugins.ui.fzf"),
  require("cantrip.plugins.ui.which-key"),
  -- buffer scrollbar
  require("cantrip.plugins.ui.scrollbar"),
  -- improved quickfix view
  require("cantrip.plugins.ui.quicker"),
  -- better inline diagnostics (line wrap, floating, etc)
  require("cantrip.plugins.ui.tiny-inline-diagnostic"),
  require("cantrip.plugins.ui.mini-trailspace"),
  require("cantrip.plugins.ui.atone"),

  require("cantrip.plugins.editing.mini-tabline"),
  require("cantrip.plugins.editing.mini-move"),
  require("cantrip.plugins.editing.mini-diff"),
  require("cantrip.plugins.editing.mini-hipatterns"),
  require("cantrip.plugins.editing.mini-ai"),
  require("cantrip.plugins.editing.mini-bufremove"),
  require("cantrip.plugins.editing.mini-surround"),
  require("cantrip.plugins.editing.mini-align"),
  -- require("cantrip.plugins.editing.sibling-swap"),
  require("cantrip.plugins.editing.inc-rename"),

  require("cantrip.plugins.ui.store"),
  -- UI enhancement plugins
  require("cantrip.plugins.ui.navic"),
  require("cantrip.plugins.ui.todo-comments"),
  require("cantrip.plugins.ui.twilight"),

  -- Editing plugins

  -- Movement plugins
  -- require("cantrip.plugins.movement.leap"),
  -- require("cantrip.plugins.movement.spider"),
  -- require("cantrip.plugins.movement.hlslens"),
  -- require("cantrip.plugins.movement.numb"),
  -- require("cantrip.plugins.movement.range-highlight")

  {}
)
