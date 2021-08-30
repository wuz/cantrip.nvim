vim.g.bufferline = {
  animation = true,
  auto_hide = false,
  tabpages = true,
  closable = true,
  clickable = true,
  icons = true,
  insert_at_end = false,
  maximum_padding = 1,
  maximum_length = 30,
  semantic_letters = true,
  letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
  no_name_title = nil
}

-- call s:hi_all([
-- \ ['BufferCurrent',        fg_current,  bg_current],
-- \ ['BufferCurrentIndex',   fg_special,  bg_current],
-- \ ['BufferCurrentMod',     fg_modified, bg_current],
-- \ ['BufferCurrentSign',    fg_special,  bg_current],
-- \ ['BufferCurrentTarget',  fg_target,   bg_current,   'bold'],
-- \ ['BufferVisible',        fg_visible,  bg_visible],
-- \ ['BufferVisibleIndex',   fg_visible,  bg_visible],
-- \ ['BufferVisibleMod',     fg_modified, bg_visible],
-- \ ['BufferVisibleSign',    fg_visible,  bg_visible],
-- \ ['BufferVisibleTarget',  fg_target,   bg_visible,   'bold'],
-- \ ['BufferInactive',       fg_inactive, bg_inactive],
-- \ ['BufferInactiveIndex',  fg_subtle,   bg_inactive],
-- \ ['BufferInactiveMod',    fg_modified, bg_inactive],
-- \ ['BufferInactiveSign',   fg_subtle,   bg_inactive],
-- \ ['BufferInactiveTarget', fg_target,   bg_inactive,  'bold'],
-- \ ['BufferTabpages',       fg_special,  bg_inactive, 'bold'],
-- \ ['BufferTabpageFill',    fg_inactive, bg_inactive],
-- \ ])
--
-- call s:hi_link([
-- \ ['BufferCurrentIcon',  'BufferCurrent'],
-- \ ['BufferVisibleIcon',  'BufferVisible'],
-- \ ['BufferInactiveIcon', 'BufferInactive'],
-- \ ['BufferOffset',       'BufferTabpageFill'],
-- \ ])
