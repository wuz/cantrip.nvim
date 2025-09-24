return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          root_dir = function(fname)
            -- Check for tailwind.config.js or tailwind.config.ts
            return require("lspconfig.util").root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
          end,
          -- to fully override the default_config, change the below
          -- filetypes = {}
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)",                    "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)",                     "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "clsx\\(((?:[^()]|\\([^()]*\\))*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "classnames\\(([^)]*)\\)",             "[\"'`]([^\"'`]*)[\"'`]" },
                  { "cva\\(([^;]*)[\\);]",                 "[`'\"`]([^'\"`;]*)[`'\"`]" },
                  { "twJoin\\(([^)]*)\\)",                 "[\"'`]([^\"'`]*)[\"'`]" },
                  { "(?:twMerge|twJoin)\\(([^;]*)[\\);]",  "[`'\"`]([^'\"`;]*)[`'\"`]" },
                  {
                    "tv\\(([^)]*)\\)",
                    "{?\\s?[\\w].*:\\s*?[\"'`]([^\"'`]*).*?,?\\s?}?",
                  },
                  { "\\b\\w*Style\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },
                  { "\\b\\w*ClassName\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },
                  { "\\b\\w*ClassNames\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },
                },
              },
            },
          },
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          local tw = Cantrip.get_raw_config("tailwindcss")
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Additional settings for Phoenix projects
          opts.settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          }

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "tailwind-language-server",
        })
      end
    end,
  },
  {
    -- Optional plugin for tailwind color preview
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- Explicitly load after blink.cmp is loaded
    dependencies = { "saghen/blink.cmp" },
    cond = function()
      -- Only load if blink.cmp is available
      return pcall(require, "blink.cmp")
    end,
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },
  -- blink.cmp + tailwind colorizer
  {
    "saghen/blink.cmp",
    dependencies = {
      "roobert/tailwindcss-colorizer-cmp.nvim",
      "saghen/blink.compat",
    },
    optional = true,
    opts = {
      sources = {
        providers = {
          tailwindcmp = {
            name = "tailwindcss-colorizer-cmp",
            score_offset = -3,
            async = true,
          },
        },
        compat = {
          "tailwindcmp",
        },
      },
    },
  },
}
