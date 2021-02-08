if g:cantrip#settings_dir
  let s:settings_file = resolve(expand(g:cantrip#settings_dir . '/settings.toml'))
else
  let s:settings_file = resolve(expand('~/.config/cantrip/settings.toml'))
endif

let s:settings = ward#toml#parse_file(s:settings_file)

function! s:let_value(name, value)
  if a:value == ''
    execute('let ' . a:name)
  else
    execute('let g:' . a:name . '="' . a:value . '"')
  endif
endfunction

function! s:set_value(name, value)
  if a:value == ''
    execute('set ' . a:name)
  else
    execute('set ' . a:name . '=' . a:value)
  endif
endfunction

function! s:parse_settings()
  for [setting_head, content] in items(s:settings)
    for [name, setting] in items(content)
      if name == 'set'
        for [key, value] in items(content[name])
          if type(value) == v:t_dict
            if has_key(value, 'if')
              if eval(value['if'])
                call s:set_value(key, get(value, 'value', ''))
              endif
            endif
          else
            call s:set_value(key, value)
          endif
        endfor
      elseif name == 'let'
        for [key, value] in items(content[name])
          if type(value) == v:t_dict
            if has_key(value, 'if')
              if eval(value['if'])
                call s:let_value(key, get(value, 'value', ''))
              endif
            endif
          else
            call s:let_value(key, value)
          endif
        endfor
      else
        execute(name . ' ' . setting)
      endif
    endfor
  endfor
endfunction

call s:parse_settings()
