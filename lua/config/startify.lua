require "string"
require "math"
local autocmd = require "utils".autocmd

autocmd("Startified", "User setlocal cursorline", true)

function repeatString(string, times)
  times = math.floor(times)
  local base = ""
  repeat
    base = base .. string
    times = times - 1
  until times == 0
  return base
end

function boxed_header(line, center)
  local boxed_header = ""
  local width = 43
  local padding = width - string.len(line)
  if center then
    if string.len(line) <= width then
      boxed_header = repeatString(" ", padding / 2) .. line .. repeatString(" ", padding / 2)
    else
      boxed_header = line.sub(0, width)
    end
  else
    if string.len(line) <= width then
      boxed_header = line .. repeatString(" ", padding)
    else
      boxed_header = line.sub(0, width)
    end
  end
  local boxed_header = "░ " .. boxed_header .. "░"
  return boxed_header
end

function map(args)
  local rv = vim.api.nvim_call_function("map", args)
  local err = vim.api.nvim_get_vvar("shell_error")
  if 0 ~= err then
    error("command failed: map(" .. args .. ")")
  end
  return rv
end

function systemlist(args)
  local rv = vim.api.nvim_call_function("systemlist", args)
  local err = vim.api.nvim_get_vvar("shell_error")
  if 0 ~= err then
    error("command failed: systemlist(" .. args .. ")")
  end
  return rv
end

local function concatArray(a, b)
  ab = {}
  table.foreach(
    a,
    function(k, v)
      table.insert(ab, v)
    end
  )
  table.foreach(
    b,
    function(k, v)
      table.insert(ab, v)
    end
  )
  return ab
end

function gitDiff()
  local files = systemlist({"git diff --name-only --diff-filter d HEAD~2 . 2>/dev/null| head -n 10 "})
  return map({files, "{'line': '.v:val, 'path': v:val}"})
end

-- returns all modified files of the current git repo
-- `2>/dev/null` makes the command fail quietly, so that when we are not
-- in a git repo, the list will be empty
function gitModified()
  local files = systemlist({"git ls-files -m 2>/dev/null"})
  return map({files, "{'line': '[M] '.v:val, 'path': v:val}"})
end

-- 	-- same as above, but show untracked files, honouring .gitignore
function gitUntracked()
  local files = systemlist({"git ls-files -o --exclude-standard 2>/dev/null"})
  return map({files, "{'line': '[?] '.v:val, 'path': v:val}"})
end

function gitFiles()
  local untracked = gitUntracked()
  local modified = gitModified()
  return concatArray(untracked, modified)
end

function cwd()
  local dir = vim.api.nvim_call_function("getcwd", {})
  return dir
  -- return dir:gsub(system("echo $HOME"), "~")
end

vim.g.startify_lists = {
  {type = "dir", header = {"   " .. cwd()}},
  {type = gitFiles, header = {"   Git Files"}},
  -- {type = gitDiff, header = {"   Git Diff (master)"}},
  {type = "files", header = {"   MRU"}},
  {type = "sessions", header = {"   Sessions"}},
  {type = "bookmarks", header = {"   Bookmarks"}},
  {type = "commands", header = {"   Commands"}}
}

vim.g.startify_files_number = 5
vim.g.startify_update_oldfiles = 1
-- vim.g.startify_disable_at_vimenter = 1
vim.g.startify_session_autoload = 1
vim.g.startify_session_persistence = 1
vim.g.startify_change_to_dir = 0

vim.g.startify_commands = {
  {u = {"Update plugins", "PackerUpdate"}},
  {c = {"Clean plugins", "PackerClean"}},
  {t = {"Time startup", "StartupTime"}},
  -- {s={'Start Prosession', 'Prosession .'}},
  {q = {"Quit", "q!"}}
}

local header = {
  "                      __         .__       ",
  "  ____ _____    _____/  |________|__|_____ ",
  [[_/ ___\\__  \  /    \   __\_  __ \  \____ \]],
  [[\  \___ / __ \|   |  \  |  |  | \/  |  |  _>]],
  [[ \___  >____  /___|  /__|  |__|  |__|   __/]],
  [[     \/     \/     \/               |__|   ]],
  "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░",
  boxed_header("", false),
  boxed_header("⁂ neovim + dark magic ⁂", true),
  boxed_header("", false),
  "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
}

function center(text)
  vim.cmd("startify#center([" .. text .. "])")
end

vim.g.startify_custom_header = header

vim.api.nvim_exec([[
hi link StartifyHeader Function
]], false)
