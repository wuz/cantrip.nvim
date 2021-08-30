local map = require "utils".map
local autocmd = require "utils.autocmd"
local cmd = vim.cmd
local execute = vim.api.nvim_command

function open_fern()
  require "bufferline.state".set_offset(31, "")
  cmd("Fern . -reveal=% -drawer -toggle<CR>")
end

function close_fern()
  require "bufferline.state".set_offset(0)
  cmd("FernDo close -drawer -stay")
end

execute('let g:fern#renderer = "nerdfont"')

-- vim.cmd([[
--     nmap <buffer><silent> <Plug>(fern-action-open-and-close) :lua open_fern() :lua close_fern()
-- ]])

-- map("n", "<Leader>/", "<Plug>(fern-action-open-and-close)")

function fern_preview_init()
  vim.cmd(
    [[
  nmap <buffer><expr>
        \ <Plug>(fern-my-preview-or-nop)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:edit)\<C-w>p",
        \   "",
        \ )
  nmap <buffer><expr> j
        \ fern#smart#drawer(
        \   "j\<Plug>(fern-my-preview-or-nop)",
        \   "j",
        \ )
  nmap <buffer><expr> k
        \ fern#smart#drawer(
        \   "k\<Plug>(fern-my-preview-or-nop)",
        \   "k",
        \ )
  ]]
  )
end

autocmd("my-fern-preview", "FileType fern lua fern_preview_init()")

vim.cmd("set hidden")
