```
          .―――――.                   ╔╦╦╦╗
      .―――│_   _│           .―.     ║~~~║
   .――│===│― C ―│_          │_│     ║~~~║――.
   │  │===│  A  │'⧹     ┌―――┤~│  ┌――╢   ║∰ │
   │%%│ ⟐ │  N  │.'⧹    │===│ │――│%%║   ║  │
   │%%│ ⟐ │  T  │⧹.'⧹   │⦑⦒ │ │__│  ║ ⧊ ║  │
   │  │ ⟐ │  R  │ ⧹.'⧹  │===│ │==│  ║   ║  │
   │  │ ⟐ │_ I _│  ⧹.'⧹ │ ⦑⦒│_│__│  ║~~~║∰ │
   │  │===│― P ―│   ⧹.'⧹│===│~│――│%%║~~~║――│
   ╰――╯―――'―――――╯    `―'`―――╯―^――^――╚╩╩╩╝――'
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░                                            ░
░           ⁂ neovim + dark magic ⁂          ░
░                                            ░
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
```

# Cantrip

<div align="center">

![GitHub issues](https://img.shields.io/github/issues-raw/wuz/cantrip) ⧊ ![GitHub top language](https://img.shields.io/github/languages/top/wuz/cantrip)

</div>

# This config is still in early development, here be dragons

# What is Cantrip?

cantrip is a Neovim config pack designed to:
1. Use cutting-edge settings and packages
2. Not break existing vim paradigms
3. Supercharge existing workflows
4. User powers > Power users

This means that packages and settings should augment existing vim commands or
add net-new functionality without breaking any existing keys.

# Installation

_coming soon_

```lua
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " "


-- Install Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Setup Cantrip
require("lazy").setup({
	spec = {
		{
			"wuz/cantrip.nvim",
			import = "cantrip.plugins",
			opts = {
				translucent = true,
				theme = "neon_magic",
			},
			init = function()
        -- Any init settings you want here
			end,
		},
		-- Language specific plugins and configs
		{ import = "cantrip.plugins.lsp.languages.lua" },
		{ import = "cantrip.plugins.lsp.languages.javascript" },
		{ import = "cantrip.plugins.lsp.languages.rust" },
		{ import = "cantrip.plugins.lsp.languages.markdown" },
		{ import = "cantrip.plugins.lsp.languages.nix" },
		{ import = "cantrip.plugins.lsp.languages.python" },
		{ import = "cantrip.plugins.lsp.languages.css" },
		-- extra plugins
		{ import = "cantrip.plugins.extras.tree" },
		{ import = "cantrip.plugins.extras.sessions" },
		{ import = "cantrip.plugins.extras.scrollbar" },
		{ import = "cantrip.plugins.extras.tailwind" },
		{ import = "cantrip.plugins.extras.colorizer" },
		{ import = "cantrip.plugins.extras.git" },
		{ import = "cantrip.plugins.inclines.harpoon" },
		-- import/override with your plugins
		{ import = "plugins" },
	},
})

```


# Settings

_coming soon_

# About the plugins

See [PLUGINS](PLUGINS.md) for a list of plugins and what they do.
