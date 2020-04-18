autocmd User Startified setlocal cursorline

function! s:boxed_header(line, center)
    let boxed_header = ""
    let width = 43
    let padding = width - strwidth(a:line)
    if (a:center)
        if (strwidth(a:line) <= width)
            let boxed_header = repeat(' ', padding/2) . a:line . repeat(' ', padding/2)
        else
            let boxed_header = strpart(a:line, 0, width)
        endif
    else
        if (strwidth(a:line) <= width)
            let boxed_header = a:line . repeat(' ', padding)
        else
            let boxed_header = strpart(a:line, 0, width)
        endif
    endif
    let boxed_header = "░ " . boxed_header . "░"
    return boxed_header
endfunction

hi link StartifyHeader Function
let g:startify_custom_header = startify#center([
            \'                      __         .__       ', 
            \'  ____ _____    _____/  |________|__|_____ ', 
            \'_/ ___\\__  \  /    \   __\_  __ \  \____ \', 
            \'\  \___ / __ \|   |  \  |  |  | \/  |  |_> >',
            \' \___  >____  /___|  /__|  |__|  |__|   __/', 
            \'     \/     \/     \/               |__|   ', 
            \'░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░',
            \'' . s:boxed_header('', 0),
            \'' . s:boxed_header('⁂ neovim + dark magic ⁂', 1),
            \'' . s:boxed_header('', 0),
            \'░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░'])


let g:startify_files_number = 5
let g:startify_list_order = [
            \ ['   [MRU] Most Recently Used files:'],
            \ 'files',
            \ ['   [MRU] in current directory:'],
            \ 'dir',
            \ ['   [CMD] Common Commands:'],
            \ 'commands',
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ]
let g:startify_commands = [
            \ {'u': ['Update Plugins', 'call dein#update()']},
            \ ]
