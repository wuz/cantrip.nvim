local Cantrip = require("cantrip.utils")

---@class cantrip.util.git
local M = {}

local branch_cache = setmetatable({}, { __mode = "k" })
local remote_cache = setmetatable({}, { __mode = "k" })

local function git_cmd(root, ...)
  local job = vim.system({ "git", "-C", root, ... }, { text = true }):wait()

  if job.code ~= 0 then
    return nil, job.stderr
  end
  return vim.trim(job.stdout)
end

--- get the path to the root of the current file. The
-- root can be anything we define, such as ".git",
-- "Makefile", etc.
-- see https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
-- @tparam  path: file to get root of
-- @treturn path to the root of the filepath parameter
M.get_path_root = function(path)
  if path == "" then
    return
  end

  local root = vim.b.path_root
  if root then
    return root
  end

  local root_items = {
    ".git",
  }

  root = vim.fs.root(path, root_items)
  if root == nil then
    return nil
  end
  if root then
    vim.b.path_root = root
  end
  return root
end

-- get the name of the remote repository
function M.get_git_remote_name(root)
  if not root then
    return nil
  end
  if remote_cache[root] then
    return remote_cache[root]
  end

  local out = git_cmd(root, "config", "--get", "remote.origin.url")
  if not out then
    return nil
  end

  -- normalise to short repo name
  out = out:gsub(":", "/"):gsub("%.git$", ""):match("([^/]+/[^/]+)$")

  remote_cache[root] = out
  return out
end

function M.get_git_branch(root)
  if not root then
    return nil
  end
  if branch_cache[root] then
    return branch_cache[root]
  end

  local out = git_cmd(root, "rev-parse", "--abbrev-ref", "HEAD")
  if out == "HEAD" then
    local commit = git_cmd(root, "rev-parse", "--short", "HEAD")
    commit = Cantrip.hl_str("Comment", "(" .. commit .. ")")
    out = string.format("%s %s", out, commit)
  end

  branch_cache[root] = out

  return out
end

return M
