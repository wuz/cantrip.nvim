return {
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = "*",
      },
    },
    event = "InsertEnter",
    -- use a release tag to download pre-built binaries
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = "enter",
        ["<A-1>"] = {
          function(cmp)
            cmp.accept { index = 1 }
          end,
        },
        ["<A-2>"] = {
          function(cmp)
            cmp.accept { index = 2 }
          end,
        },
        ["<A-3>"] = {
          function(cmp)
            cmp.accept { index = 3 }
          end,
        },
        ["<A-4>"] = {
          function(cmp)
            cmp.accept { index = 4 }
          end,
        },
        ["<A-5>"] = {
          function(cmp)
            cmp.accept { index = 5 }
          end,
        },
        ["<A-6>"] = {
          function(cmp)
            cmp.accept { index = 6 }
          end,
        },
        ["<A-7>"] = {
          function(cmp)
            cmp.accept { index = 7 }
          end,
        },
        ["<A-8>"] = {
          function(cmp)
            cmp.accept { index = 8 }
          end,
        },
        ["<A-9>"] = {
          function(cmp)
            cmp.accept { index = 9 }
          end,
        },
        ["<A-0>"] = {
          function(cmp)
            cmp.accept { index = 10 }
          end,
        },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      signature = {
        window = {
          border = "single",
        },
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        list = {
          selection = {
            auto_insert = true,
            preselect = function(ctx)
              return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active { direction = 1 }
            end,
          },
        },
        menu = {
          border = "single",
          draw = {
            treesitter = { "lsp" },
            columns = { { "item_idx" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
            components = {
              item_idx = {
                text = function(ctx)
                  return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
                end,
                highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
              },
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
        documentation = {
          window = {
            border = "single",
          },
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        min_keyword_length = function(ctx)
          -- only applies when typing a command, doesn't apply to arguments
          if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
            return 2
          end
          return 0
        end,
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
      },
    },

    config = function(_, opts)
      opts.sources.compat = nil
      require("blink.cmp").setup(opts)
    end,
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
  },
  -- {
  --   "saghen/blink.cmp",
  --   opts = function(_, opts)
  --     opts.appearance = opts.appearance or {}
  --     opts.appearance.kind_icons = vim.tbl_extend("keep", {
  --       Color = "██", -- Use block instead of icon for color items to make swatches more usable
  --     }, {})
  --   end,
  -- },

  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
}
