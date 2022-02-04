local M = {}

M.setup = function()
  local map = require("cartographer")
  require("focus").setup()

  map.n.nore.silent["<c-s>"] = ":FocusSplitNicely<CR>"
end

return M
