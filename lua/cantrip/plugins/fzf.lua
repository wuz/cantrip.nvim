local function symbols_filter(entry, ctx)
  if ctx.symbols_filter == nil then
    ctx.symbols_filter = false
  end
  if ctx.symbols_filter == false then
    return true
  end
  return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

local function opts(_, opts)
  local fzf = require("fzf-lua")
  local config = fzf.config
  local actions = fzf.actions

  -- Quickfix
  config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
  config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
  config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
  config.defaults.keymap.fzf["ctrl-x"] = "jump"
  config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
  config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
  config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
  config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
  config.defaults.actions.files["ctrl-t"] = require("trouble.sources.fzf").actions.open

  local img_previewer ---@type string[]?
  for _, v in ipairs {
    { cmd = "ueberzug", args = {} },
    { cmd = "chafa", args = { "{file}", "--format=symbols" } },
    { cmd = "viu", args = { "-b" } },
  } do
    if vim.fn.executable(v.cmd) == 1 then
      img_previewer = vim.list_extend({ v.cmd }, v.args)
      break
    end
  end

  return {
    "default-title",
    fzf_colors = true,
    fzf_opts = {
      ["--no-scrollbar"] = true,
    },
    oldfiles = {
      -- In Telescope, when I used <leader>fr, it would load old buffers.
      -- fzf lua does the same, but by default buffers visited in the current
      -- session are not included. I use <leader>fr all the time to switch
      -- back to buffers I was just in. If you missed this from Telescope,
      -- give it a try.
      include_current_session = true,
    },
    previewers = {
      builtin = {
        -- fzf-lua is very fast, but it really struggled to preview a couple files
        -- in a repo. Those files were very big JavaScript files (1MB, minified, all on a single line).
        -- It turns out it was Treesitter having trouble parsing the files.
        -- With this change, the previewer will not add syntax highlighting to files larger than 100KB
        -- (Yes, I know you shouldn't have 100KB minified files in source control.)
        syntax_limit_b = 1024 * 100, -- 100KB
      },
    },
    grep = {
      -- One thing I missed from Telescope was the ability to live_grep and the
      -- run a filter on the filenames.
      -- Ex: Find all occurrences of "enable" but only in the "plugins" directory.
      -- With this change, I can sort of get the same behaviour in live_grep.
      -- ex: > enable --*/plugins/*
      -- I still find this a bit cumbersome. There's probably a better way of doing this.
      rg_glob = true, -- enable glob parsing
      glob_flag = "--iglob", -- case insensitive globs
      glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
    },
    defaults = {
      -- formatter = "path.filename_first",
      formatter = "path.dirname_first",
    },
    previewers = {
      builtin = {
        extensions = {
          ["png"] = img_previewer,
          ["jpg"] = img_previewer,
          ["jpeg"] = img_previewer,
          ["gif"] = img_previewer,
          ["webp"] = img_previewer,
        },
        ueberzug_scaler = "fit_contain",
      },
    },
    -- Custom LazyVim option to configure vim.ui.select
    ui_select = function(fzf_opts, items)
      return vim.tbl_deep_extend("force", fzf_opts, {
        prompt = " ",
        winopts = {
          title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
          title_pos = "center",
        },
      }, fzf_opts.kind == "codeaction" and {
        winopts = {
          layout = "vertical",
          -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
          height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
          width = 0.5,
          preview = not vim.tbl_isempty(vim.lsp.get_clients { bufnr = 0, name = "vtsls" }) and {
            layout = "vertical",
            vertical = "down:15,border-top",
            hidden = "hidden",
          } or {
            layout = "vertical",
            vertical = "down:15,border-top",
          },
        },
      } or {
        winopts = {
          width = 0.5,
          -- height is number of items, with a max of 80% screen height
          height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
        },
      })
    end,
    winopts = {
      width = 0.8,
      height = 0.8,
      row = 0.5,
      col = 0.5,
      preview = {
        scrollchars = { "┃", "" },
      },
    },
    files = {
      cwd_prompt = false,
      actions = {
        ["alt-i"] = { actions.toggle_ignore },
        ["alt-h"] = { actions.toggle_hidden },
      },
    },
    grep = {
      actions = {
        ["alt-i"] = { actions.toggle_ignore },
        ["alt-h"] = { actions.toggle_hidden },
      },
    },
    lsp = {
      symbols = {
        symbol_hl = function(s)
          return "TroubleIcon" .. s
        end,
        symbol_fmt = function(s)
          return s:lower() .. "\t"
        end,
        child_prefix = false,
      },
      code_actions = {
        previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
      },
    },
  }
end

return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    opts = opts,
    config = function(_, opts)
      if opts[1] == "default-title" then
        -- use the same prompt for all pickers for profile `default-title` and
        -- profiles that use `default-title` as base profile
        local function fix(t)
          t.prompt = t.prompt ~= nil and " " or nil
          for _, v in pairs(t) do
            if type(v) == "table" then
              fix(v)
            end
          end
          return t
        end
        opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
        opts[1] = nil
      end
      require("fzf-lua").setup(opts)
    end,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load { plugins = { "fzf-lua" } }
        require("fzf-lua").register_ui_select()
        return vim.ui.select(...)
      end
    end,

    keys = {

      {
        "<c-j>",
        "<c-j>",
        ft = "fzf",
        mode = "t",
        nowait = true,
      },
      {
        "<c-k>",
        "<c-k>",
        ft = "fzf",
        mode = "t",
        nowait = true,
      },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>fg",
        "<cmd>FzfLua git_files<cr>",
        desc = "Find Files (git-files)",
      },
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Recent" },
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>fa", "<cmd>FzfLua live_grep_native<cr>", desc = "Search in files" },
      { "<leader>ft", "<cmd>FzfLua tags<cr>", desc = "Tags" },
      -- git
      { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      -- search
      { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      {
        "<leader>sD",
        "<cmd>FzfLua diagnostics_workspace<cr>",
        desc = "Workspace Diagnostics",
      },
      {
        "<leader>sH",
        "<cmd>FzfLua highlights<cr>",
        desc = "Search Highlight Groups",
      },
      { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
      { "<leader><leader>", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
      {
        "<leader>ss",
        function()
          require("fzf-lua").lsp_document_symbols {
            regex_filter = symbols_filter,
          }
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("fzf-lua").lsp_live_workspace_symbols {
            regex_filter = symbols_filter,
          }
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>st", function() require("todo-comments.fzf").todo() end,                                          desc = "Todo" },
      { "<leader>sT", function() require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("cantrip.plugins.lsp.keymaps").get()
      -- stylua: ignore
      vim.list_extend(Keys, {
        { "gd", "<cmd>FzfLua lsp_definitions     jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Definition",       has = "definition" },
        { "gr", "<cmd>FzfLua lsp_references      jump_to_single_result=true ignore_current_line=true<cr>", desc = "References",            nowait = true },
        { "gI", "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto Implementation" },
        { "gy", "<cmd>FzfLua lsp_typedefs        jump_to_single_result=true ignore_current_line=true<cr>", desc = "Goto T[y]pe Definition" },
      })
    end,
  },
}
