-- reverse.lua
local M = {}

local function reverse_lines(start_line, end_line)
  -- Ensure the lines exist
  if start_line < 1 or end_line < 1 or start_line > vim.fn.line("$") or end_line > vim.fn.line("$") then
    print("..error")
    return
  end

  -- Swap lines from start_line to end_line
  local t1, t2 = start_line, end_line
  if t1 > t2 then
    t1, t2 = t2, t1
  end

  local diff = t2 - t1 + 1
  local counter = math.floor(diff / 2)

  while counter > 0 do
    local text1 = vim.fn.getline(t1)
    local text2 = vim.fn.getline(t2)

    vim.fn.setline(t1, text2)
    vim.fn.setline(t2, text1)

    t1 = t1 + 1
    t2 = t2 - 1
    counter = counter - 1
  end
end

function M.reverse()
  local rangeStart = vim.fn.getpos("v")[2]
  local rangeEnd = vim.fn.getpos(".")[2]

  if rangeStart ~= 0 and rangeEnd ~= 0 then
    reverse_lines(rangeStart, rangeEnd)
  else
    reverse_lines(1, vim.fn.line("$"))
  end
end

function M.setup()
  -- Create the Reverse command for visual selection
  vim.api.nvim_create_user_command("Reverse", function(opts)
    if opts.range == 2 then
      reverse_lines(opts.line1, opts.line2)
    else
      reverse_lines(1, vim.fn.line("$"))
    end
  end, { range = true })
end

return M
