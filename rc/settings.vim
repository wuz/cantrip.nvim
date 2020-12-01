
let s:settings_file = resolve(expand('~/.config/nvim/settings/settings.toml'))

let s:settings = ward#toml#parse_file(s:settings_file)

function! s:set_value(name, value)
  if a:value == ''
    execute('set ' . a:name)
  else
    execute('set ' . a:name . '=' . a:value)
  endif
endfunction

function! s:parse_settings(setting)
  if has_key(s:settings, a:setting)
    for [name, setting] in items(s:settings[a:setting])
      if name == 'set'
        for [key, value] in items(s:settings[a:setting][name])
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
      else
        execute(name . ' ' . setting)
      endif
    endfor
  endif
endfunction

call s:parse_settings('appearance')
call s:parse_settings('folding')
call s:parse_settings('search')
call s:parse_settings('indent')
call s:parse_settings('undo')
