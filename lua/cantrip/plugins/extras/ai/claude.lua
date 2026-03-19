local toggle_key = "<leader>aC"

local function clear_terminal()
  -- Get the channel ID of the current terminal buffer
  local chan_id = vim.bo.channel

  -- Check if we're in a terminal buffer
  if chan_id == nil then
    print("Not in a terminal buffer")
    return
  end

  -- Check if we're in normal mode and switch to insert mode if needed
  local mode = vim.api.nvim_get_mode().mode
  if mode == "n" or mode == "nt" then
    vim.cmd("startinsert")
  end

  -- Send /clear followed by Enter
  vim.api.nvim_chan_send(chan_id, "/clear")
end

return {
  {
    "coder/claudecode.nvim",
    lazy = false,
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
    },
    dependencies = { "folke/snacks.nvim", "sindrets/diffview.nvim" },
    opts = {},
    config = function(_, opts)
      vim.o.autoread = true
      local is_git_ignored = function(filepath)
        vim.fn.system("git check-ignore -q " .. vim.fn.shellescape(filepath))
        return vim.v.shell_error == 0
      end

      local update_left_pane = function()
        pcall(function()
          local lib = require("diffview.lib")
          local view = lib.get_current_view()
          if view then
            -- This updates the left panel with all the files, but doesn't update the buffers
            view:update_files()
          end
        end)
      end

      vim.api.nvim_create_autocmd("FocusGained", {
        callback = update_left_pane,
      })
      --
      -- Register handler for file changes in watched directory
      require("cantrip.plugins.extras.ai.directory-watcher").registerOnChangeHandler(
        "diffview",
        function(filepath, events)
          local is_in_dot_git_dir = filepath:match("/%.git/") or filepath:match("^%.git/")

          if is_in_dot_git_dir or not is_git_ignored(filepath) then
            update_left_pane()
          end
        end
      )

      require("cantrip.plugins.extras.ai.hotreload").setup()
      require("claudecode").setup(opts)
    end,
    keys = {
      {
        "<D-K>",
        clear_terminal,
        mode = "t",
        desc = "Clear claude terminal",
        { noremap = true },
      },
      { "<leader>a", nil, desc = "AI" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { toggle_key, "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
