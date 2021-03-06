" =============================================================================
" File: plugin/move.vim
" Description: Move lines and selections up and even down.
" Author: Matthias Vogelgesang <github.com/matze>
" =============================================================================

if exists('loaded_move') || &cp
  finish
endif

let loaded_move = 1

if !exists('g:move_map_keys')
  let g:move_map_keys = 1
endif

if !exists('g:move_key_modifier')
  let g:move_key_modifier = 'C'
endif

if !exists('g:move_auto_indent')
  let g:move_auto_indent = 1
endif

function! s:ResetCursor()
  normal! gv=gv^
endfunction

function! s:MoveBlockDown(start, end, count)
  let next_line = a:end + a:count

  if v:count > 0
    let next_line = next_line + v:count - 1
  endif

  if next_line > line('$')
    call s:ResetCursor()
    return
  endif

  execute "silent" a:start "," a:end "m " next_line
  if (g:move_auto_indent == 1)
    call s:ResetCursor()
  else
    normal! gv
  endif
endfunction

function! s:MoveBlockUp(start, end, count)
  let prev_line = a:start - a:count - 1

  if v:count > 0
    let prev_line = prev_line - v:count + 1
  endif

  if prev_line < 0
    call s:ResetCursor()
    return
  endif

  execute "silent" a:start "," a:end "m " prev_line
  if (g:move_auto_indent == 1)
    call s:ResetCursor()
  else
    normal! gv
  endif
endfunction

function! s:MoveBlockOneLineUp() range
  call s:MoveBlockUp(a:firstline, a:lastline, 1)
endfunction

function! s:MoveBlockOneLineDown() range
  call s:MoveBlockDown(a:firstline, a:lastline, 1)
endfunction

function! s:MoveBlockHalfPageUp() range
  let distance = winheight('.') / 2
  call s:MoveBlockUp(a:firstline, a:lastline, distance)
endfunction

function! s:MoveBlockHalfPageDown() range
  let distance = winheight('.') / 2
  call s:MoveBlockDown(a:firstline, a:lastline, distance)
endfunction

function! s:MoveKey(key)
  return '<' . g:move_key_modifier . '-' . a:key . '>'
endfunction

vnoremap <silent> <Plug>MoveBlockDown           :call <SID>MoveBlockOneLineDown()<CR>
vnoremap <silent> <Plug>MoveBlockUp             :call <SID>MoveBlockOneLineUp()<CR>
vnoremap <silent> <Plug>MoveBlockHalfPageDown   :call <SID>MoveBlockHalfPageDown()<CR>
vnoremap <silent> <Plug>MoveBlockHalfPageUp     :call <SID>MoveBlockHalfPageUp()<CR>

if g:move_map_keys
  execute 'vmap' s:MoveKey('j') '<Plug>MoveBlockDown'
  execute 'vmap' s:MoveKey('k') '<Plug>MoveBlockUp'
endif
