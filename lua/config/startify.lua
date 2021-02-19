require'string'
require'math'
local autocmd = require'utils'.autocmd

autocmd('Startified', 'User setlocal cursorline', true)

function repeatString(string, times)
	times = math.floor(times)
	local base = ''
	repeat
		base = base..string
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
			boxed_header = repeatString(' ', padding / 2) .. line .. repeatString(' ', padding / 2)
		else
			boxed_header = line.sub(0, width)
		end
	else
		if string.len(line) <= width then
			boxed_header = line .. repeatString(' ', padding)
		else
			boxed_header = line.sub(0, width)
		end
	end
	local boxed_header = "░ " .. boxed_header .. "░"
	return boxed_header
end

vim.g.startify_files_number = 5
vim.g.startify_update_oldfiles = 1
-- vim.g.startify_disable_at_vimenter = 1
vim.g.startify_session_autoload = 1
vim.g.startify_session_persistence = 1
vim.g.startify_change_to_dir = 0
vim.g.startify_list_order = {
	{'   [MRU] Most Recently Used files:'},
	'files',
	{'   [MRU] in current directory:'},
	'dir',
	{'   [CMD] Common Commands:'},
	'commands',
	{'   Sessions:'},
	'sessions',
	{'   Bookmarks:'},
	'bookmarks',
}

vim.g.startify_commands = {
	{u={'Update plugins', 'PackerUpdate'}},
	{c={'Clean plugins', 'PackerClean'}},
	{t={'Time startup', 'StartupTime'}},
	-- {s={'Start Prosession', 'Prosession .'}},
	{q={'Quit', 'q!'}}
}


local header = {
	'                      __         .__       ',
	'  ____ _____    _____/  |________|__|_____ ',
	[[_/ ___\\__  \  /    \   __\_  __ \  \____ \]],
	[[\  \___ / __ \|   |  \  |  |  | \/  |  |  _>]],
	[[ \___  >____  /___|  /__|  |__|  |__|   __/]],
	[[     \/     \/     \/               |__|   ]],
	'░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
	boxed_header('', false),
	boxed_header('⁂ neovim + dark magic ⁂', true), 
	boxed_header('', false),
	'░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░'
}

function center(text)
	vim.cmd('startify#center(['..text..'])')
end

vim.g.startify_custom_header = header

vim.api.nvim_exec([[
hi link StartifyHeader Function
	]], false)
