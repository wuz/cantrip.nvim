local cmd = vim.cmd
local o_s = vim.o
local map_key = vim.api.nvim_set_keymap
local del_key = vim.api.nvim_del_keymap

local function opt(o, v, scopes)
  scopes = scopes or {o_s}
  for _, s in ipairs(scopes) do
    s[o] = v
  end
end

local function map(modes, lhs, rhs, opts, desc)
  desc = desc or rhs
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == "string" then
    modes = {modes}
  end
  for _, mode in ipairs(modes) do
    map_key(mode, lhs, rhs, opts)
  end
end

local function unmap(modes, key, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == "string" then
    modes = {modes}
  end
  for _, mode in ipairs(modes) do
    del_key(mode, key, opts)
  end
end

local function termcode(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function command(name, exec)
  cmd("command! -bang -nargs=? -complete=dir " .. name .. " call " .. exec)
end

return {opt = opt, map = map, termcode = termcode, command = command}
