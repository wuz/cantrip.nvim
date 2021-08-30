local o = vim.o

-- Search
o.incsearch = true -- search as characters are typed
o.hlsearch = true -- highlight matches
o.ignorecase = true -- ignore case of searches
o.gdefault = true -- default to global search
o.smartcase = true -- ignore ignorecase if uppercase letters
o.wrapscan = true -- search wraps around end of file
