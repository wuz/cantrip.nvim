return {
  {
    -- Toggle comments
    "echasnovski/mini.comment",
    version = false,
    config = true,
  },
  {
    -- Highlight trailing spaces
    "echasnovski/mini.trailspace",
    version = false,
    config = true,
  },
  {
    -- Surround code
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "Za", -- Add surrounding in Normal and Visual modes
        delete = "Zd", -- Delete surrounding
        find = "Zf", -- Find surrounding (to the right)
        find_left = "ZF", -- Find surrounding (to the left)
        highlight = "Zh", -- Highlight surrounding
        replace = "Zr", -- Replace surrounding
        update_n_lines = "Zn", -- Update `n_lines`
      },
    },
  },
  { "echasnovski/mini.align", version = false },
}
