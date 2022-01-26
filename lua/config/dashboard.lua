local g = vim.g
local utils = require("telescope.utils")

g.dashboard_default_executive = "telescope"

local function boxed_header(line, center)
  local header_string = ""
  local width = 80
  local padding = width - string.len(line)
  if center then
    local pad = math.floor(padding / 2)
    header_string = string.rep(" ", pad) .. line .. string.rep(" ", pad)
  else
    header_string = line .. string.rep(" ", padding)
  end
  return header_string
end

local _, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, vim.loop.cwd())
local set_var = vim.api.nvim_set_var

local function get_dashboard_git_status()
  local git_cmd = { "git", "status", "-s", "--", "." }
  local output = utils.get_os_command_output(git_cmd)
  set_var("dashboard_custom_footer", { "Git status", "", unpack(output) })
end

if ret ~= 0 then
  local is_worktree = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" }, vim.loop.cwd())
  if is_worktree[1] == "true" then
    get_dashboard_git_status()
  else
    set_var("dashboard_custom_footer", { "Not in a git directory" })
  end
else
  get_dashboard_git_status()
end

local total_plugins = #vim.tbl_keys(packer_plugins)

local header = {
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
  "             loaded " .. total_plugins .. " plugins",
}

g.dashboard_custom_header = header

g.dashboard_custom_section = {
  a = {
    description = { " New Buffer" },
    command = "DashboardNewFile",
  },
  b = {
    description = { "  Load Session" },
    command = "SessionLoad",
  },
  c = {
    description = { "  Recents" },
    command = "DashboardFindHistory",
  },
  f = {
    description = { " Edit Config" },
    command = "e ~/.config/nvim/lua/cantriprc.lua",
  },
  g = {
    description = { "  Update Plugins" },
    command = "PackerUpdate",
  },
}
