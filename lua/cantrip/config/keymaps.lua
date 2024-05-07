local map = vim.keymap.set

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- map("n", "<Leader>q", ":Bdelete<CR>", opts, "Close Buffer")

map("n", "+", ':exe "resize " . (winheight(0) * 6/5)<CR>', { desc = "Increase window height" })
map("n", "-", ':exe "resize " . (winheight(0) * 5/6)<CR>', { desc = "Descrease window height" })
map("n", "<Leader>+", ':exe "vertical resize " . (winwidth(0) * 6/5)<CR>', { desc = "Increase window width" })
map("n", "<Leader>-", ':exe "vertical resize " . (winwidth(0) * 5/6)<CR>', { desc = "Decrease window width" })

map("n", "<leader>|", ":vsplit<CR><C-w><C-w>", { desc = "Split vertically" })
map("n", "<leader>-", ":split<CR><C-w><C-w>", { desc = "Split horizontally" })
--
-- map("t", "<Esc>", "<C-\\><C-n>", opts)
-- map("t", "<M-[>", "<Esc>", opts)
-- map("t", "<C-v><Esc>", "<Esc>", opts)
--
-- vim.g.git_messenger_no_default_mappings = true
-- map("n", "<leader>,", ":GitMessenger<CR>", opts)
--
map("n", "<leader>ss", ":lua MiniSessions.write()<CR>")
map("n", "<leader>sl", ":lua MiniSessions.select()<CR>")
map("n", "<leader>ls", ":lua MiniSessions.read()<CR>")
--
-- -- vim.cmd([[
-- -- nmap S <plug>(SubversiveSubstitute)
-- -- nmap SS <plug>(SubversiveSubstituteLine)
-- -- ]])
--
-- -- paste from system clipboard
map({ "n", "v" }, "<leader>p", '"+p')
map({ "n", "v" }, "<leader>P", '"+P')

map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "<leader>Y", '"+Y')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
