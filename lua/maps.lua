local map = require "utils".map
local autocmd = require "utils.autocmd"

local opts = {noremap = true}

-- map("n", "<C-h>", "<Plug>(cokeline-focus-prev)", silent, "Previous Buffer")
-- map("n", "<C-l>", "<Plug>(cokeline-focus-next)", silent, "Next Buffer")
vim.cmd([[
  nmap <silent> <C-h> :BufferLineCyclePrev<CR>
  nmap <silent> <C-l> :BufferLineCycleNext<CR>
]])
map("n", "<Leader>q", ":Bdelete<CR>", opts, "Close Buffer")

map("n", "j", "gj", opts)
map("n", "k", "gk", opts)

map("n", "+", ':exe "resize " . (winheight(0) * 6/5)<CR>', opts)
map("n", "-", ':exe "resize " . (winheight(0) * 5/6)<CR>', opts)
map("n", "<leader><", ':exe "vertical resize " . (winwidth(0) * 6/5)<CR>', opts)
map("n", "<leader>>", ':exe "vertical resize " . (winwidth(0) * 5/6)<CR>', opts)

map("n", "<leader>|", ":vsplit<CR><C-w><C-w>", opts)
map("n", "<leader>-", ":split<CR><C-w><C-w>", opts)

map("t", "<Esc>", "<C-\\><C-n>", opts)
map("t", "<M-[>", "<Esc>", opts)
map("t", "<C-v><Esc>", "<Esc>", opts)

vim.g.git_messenger_no_default_mappings = true
map("n", "<leader>,", ":GitMessenger<CR>", opts)

map("n", "<leader>ss", ":<C-u>SessionSave<CR>")
map("n", "<leader>sl", ":<C-u>SessionLoad<CR>")

-- vim.cmd([[
-- nmap S <plug>(SubversiveSubstitute)
-- nmap SS <plug>(SubversiveSubstituteLine)
-- ]])

-- paste from system clipboard
map({n, v}, "<leader>p", '"+p', opts)
map({n, v}, "<leader>P", '"+P', opts)

map({n, v}, "<leader>y", '"+y', opts)
map({n, v}, "<leader>Y", '"+Y', opts)

map("n", "<leader>d", '"+dd', opts)
map("v", "<leader>d", '"+d', opts)

-- trouble
map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
