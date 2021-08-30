local map = require "utils".map
local autocmd = require "utils.autocmd"

map("n", "<C-h>", ":BufferPrevious<CR>", noremap, "Previous Buffer")
map("n", "<C-l>", ":BufferNext<CR>", noremap, "Next Buffer")
map("n", "<leader>q", ":BufferClose<CR>", noremap, "Close Buffer")

map("n", "j", "gj", noremap)
map("n", "k", "gk", noremap)

map("n", "+", ':exe "resize " . (winheight(0) * 6/5)<CR>', noremap)
map("n", "-", ':exe "resize " . (winheight(0) * 5/6)<CR>', noremap)
map("n", "<leader><", ':exe "vertical resize " . (winwidth(0) * 6/5)<CR>', noremap)
map("n", "<leader>>", ':exe "vertical resize " . (winwidth(0) * 5/6)<CR>', noremap)

map("n", "<leader>|", ":vsplit<CR><C-w><C-w>", noremap)
map("n", "<leader>-", ":split<CR><C-w><C-w>", noremap)

map("t", "<Esc>", "<C-\\><C-n>", noremap)
map("t", "<M-[>", "<Esc>", noremap)
map("t", "<C-v><Esc>", "<Esc>", noremap)

vim.g.git_messenger_no_default_mappings = true
map("n", "<leader>,", ":GitMessenger<CR>", noremap)

map("n", "<leader>ss", ":<C-u>SessionSave<CR>")
map("n", "<leader>sl", ":<C-u>SessionLoad<CR>")

-- vim.cmd([[
-- nmap S <plug>(SubversiveSubstitute)
-- nmap SS <plug>(SubversiveSubstituteLine)
-- ]])

map("v", "<leader>y", '"+y', noremap)

-- delete to system clipboard
map("v", "<leader>d", '"+d', noremap)

-- paste from system clipboard
map("n", "<leader>p", '"+p', noremap)
map("n", "<leader>P", '"+P', noremap)
map("v", "<leader>p", '"+p', noremap)
map("v", "<leader>P", '"+P', noremap)
