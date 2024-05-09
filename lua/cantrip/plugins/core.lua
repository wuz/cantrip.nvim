--[[
-- core.lua
-- Core functionality improvements for nvim
--]]
--

return {
  -- Plugin manager
  { "folke/lazy.nvim",      version = "*" },
  -- Load cantrip as a plugin
  {
    "wuz/cantrip.nvim",
    lazy = false,     -- make sure we load this during startup
    priority = 10000, -- load before anything else
    version = "*",
    config = true,
  },
  -- Lua utils
  { "nvim-lua/plenary.nvim" },
  -- Fix weirdness with filetypes
  {
    "nathom/filetype.nvim",
    opts = function()
      return {
        overrides = {
          function_extensions = {
            ["json"] = function()
              vim.bo.filetype = "jsonc"
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      require("filetype").setup(opts)
    end,
  },
  -- Fix weirdness with cursor hold
  { "antoinemadec/FixCursorHold.nvim" },
  -- Make more things repeatable
  { "tpope/vim-repeat" },
  -- Gotta go fast
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
  },
  -- highlight selected range from commandline
  {
    "winston0410/range-highlight.nvim",
    dependencies = { "winston0410/cmd-parser.nvim" },
  },
  -- better scrolling
  {
    "karb94/neoscroll.nvim",
    config = true,
  },
  -- Disable relative numbers when they don't make sense
  {
    "nkakouros-original/numbers.nvim",
  },
  -- Bufremove
  {
    "echasnovski/mini.bufremove",
    version = false,
    config = function()
      require("mini.bufremove").setup()
    end,
  },
  -- Enable harpoon workflows
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>h"] = { name = "+harpoon" },
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = function()
      local harpoon = require("harpoon")
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
            })
            :find()
      end
      return {
        {
          "<leader>ha",
          function()
            harpoon:list():add()
          end,
          desc = "Add file to harpoon list",
        },
        {
          "<leader>hr",
          function()
            harpoon:list():remove()
          end,
          desc = "Remove file from harpoon list",
        },
        {
          "<leader>ht",
          function()
            toggle_telescope(harpoon:list())
          end,
          desc = "",
        },
        {
          "<leader>h1",
          function()
            harpoon:list():select(1)
          end,
        },
        {
          "<leader>h2",
          function()
            harpoon:list():select(2)
          end,
        },
        {
          "<leader>h3",
          function()
            harpoon:list():select(3)
          end,
        },
        {
          "<leader>h4",
          function()
            harpoon:list():select(4)
          end,
        },

        -- Toggle previous & next buffers stored within Harpoon list
        {
          "[h",
          function()
            harpoon:list():prev()
          end,
        },
        {
          "]h",
          function()
            harpoon:list():next()
          end,
        },
      }
    end,
    opts = {},
    config = function(_, opts)
      local harpoon = require("harpoon")
      harpoon:setup(opts)
    end,
  },
}
