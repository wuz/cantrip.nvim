return {
  {
    "goolord/alpha-nvim",
    dependencies = { "echasnovski/mini.icons", "ThePrimeagen/harpoon", "nvim-telescope/telescope.nvim" },
    opts = function()
      local harpoon = require("harpoon")
      local dashboard = require("alpha.themes.dashboard")
      local conf = require("telescope.config").values
      local function button(sc, txt, keybind)
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

        local opts = {
          position = "center",
          text = txt,
          shortcut = sc,
          cursor = 5,
          width = 36,
          align_shortcut = "right",
          hl = "AlphaButtons",
        }

        if keybind then
          opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
        end

        return {
          type = "button",
          val = txt,
          on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
            vim.api.nvim_feedkeys(key, "normal", false)
          end,
          opts = opts,
        }
      end

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

      local ascii = {
        "       .―――――.                   ╔╦╦╦╗   ",
        "   .―――│_   _│           .―.     ║~~~║   ",
        ".――│===│― C ―│_          │_│     ║~~~║――.",
        "│  │===│  A  │'⧹     ┌―――┤~│  ┌――╢   ║∰ │",
        "│%%│ ⟐ │  N  │.'⧹    │===│ │――│%%║   ║  │",
        "│%%│ ⟐ │  T  │⧹.'⧹   │⦑⦒ │ │__│  ║ ⧊ ║  │",
        "│  │ ⟐ │  R  │ ⧹.'⧹  │===│ │==│  ║   ║  │",
        "│  │ ⟐ │_ I _│  ⧹.'⧹ │ ⦑⦒│_│__│  ║~~~║∰ │",
        "│  │===│― P ―│   ⧹.'⧹│===│~│――│%%║~~~║――│",
        "╰――╯―――'―――――╯    `―'`―――╯―^――^――╚╩╩╩╝――'",
        "          ⁂ neovim + dark magic ⁂",
      }

      dashboard.section.header.val = ascii

      dashboard.section.buttons.val = {
        button("h", "󰛢  Harpooned  ", function()
          toggle_telescope(harpoon:list())
        end),
        button("<space>", "  Find File  ", ":Telescope find_files<CR>"),
        button("m", "  Recent File  ", ":Telescope oldfiles<CR>"),
        button("n", "  New file  ", ":ene <BAR> startinsert <CR>"),
        button("a", "  Find Word  ", ":Telescope live_grep<CR>"),
      }
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "cantrip loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
