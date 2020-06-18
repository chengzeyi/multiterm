let s:cpo_save = &cpo
set cpo&vim

if exists('s:loaded')
    finish
endif
let s:loaded = 1

let s:multiterm_default_opts = {
            \ 'height': 'float2nr(&lines * 0.8)',
            \ 'width': 'float2nr(&columns * 0.8)',
            \ 'row': '(&lines - height) / 2',
            \ 'col': '(&columns - width) / 2',
            \ 'border_hl': 'Comment',
            \ 'border_chars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
            \ 'term_hl': 'Normal'
            \ }

if !exists('g:multiterm_opts')
    let g:multiterm_opts = {}
endif

call extend(g:multiterm_opts, s:multiterm_default_opts, 'keep')

command! -nargs=* -complete=shellcmd -count -bang Multiterm call multiterm#toggle_float_term(<count>, <bang>0, 0, <q-args>)

nnoremap <silent> <Plug>(Multiterm) :<C-u>call multiterm#toggle_float_term(v:count, 0, 0)<Cr>
xnoremap <silent> <Plug>(Multiterm) :<C-u>call multiterm#toggle_float_term(v:count, 0, 0)<Cr>
inoremap <silent> <Plug>(Multiterm) <C-o>:<C-u>call multiterm#toggle_float_term(v:count, 0, 0)<Cr>
if has('nvim')
    tnoremap <silent> <Plug>(Multiterm) <C-\><C-n>:<C-u>call multiterm#toggle_float_term(v:count, 0, 1)<Cr>
else
    if empty(&termwinkey) || &termwinkey =~? '\V<c-w>'
        tnoremap <silent> <Plug>(Multiterm) <C-w>:<C-u>call multiterm#toggle_float_term(v:count, 0, 0)<Cr>
    else
        tnoremap <silent> <Plug>(Multiterm) <C-\><C-n>:<C-u>call multiterm#toggle_float_term(v:count, 0, 1)<Cr>
    endif
endif

let &cpo = s:cpo_save
unlet s:cpo_save