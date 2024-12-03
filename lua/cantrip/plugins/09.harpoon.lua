return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts_extend = { "spec" },
    opts = {
      ---@type wk.Spec
      spec = {
        { "<leader>h", name = "+harpoon" },
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "neovim/nvim-lspconfig",
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
