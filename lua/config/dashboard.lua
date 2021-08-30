local g = vim.g

g.dashboard_default_executive = "telescope"

function boxed_header(line, center)
  local header_string = ""
  local width = 36
  local padding = width - string.len(line)
  if center then
    local pad = math.floor(padding / 2)
    header_string = string.rep(" ", pad) .. line .. string.rep(" ", pad)
  else
    header_string = line .. string.rep(" ", padding)
  end
  return "░" .. header_string .. "░"
end

g.dashboard_custom_header = {
  "                                         ",
  "                                         ",
  "                                         ",
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
  "                                         ",
  "                                         "
}

g.dashboard_custom_section = {
  a = {
    description = {"  Find File"},
    command = "Telescope find_files"
  },
  b = {
    description = {"  Recents"},
    command = "Telescope oldfiles"
  },
  c = {
    description = {"  Update Plugins"},
    command = "PackerUpdate"
  },
  e = {
    description = {" New Buffer"},
    command = "enew"
  },
  f = {
    description = {" Edit Config"},
    command = "e ~/.config/nvim/lua/cantriprc.lua"
  }
}

g.dashboard_custom_footer = {
  "░       ⁂ neovim + dark magic ⁂      ░"
}
