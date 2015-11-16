
" platform {{{
  " osx {{{
    silent function! OSX()
      return has('macunix')
    endfunction
  " }}}
  " linux {{{
    silent function! LINUX()
      return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
  " }}}
  " winx {{{
    silent function! WINX()
      return (has('win16') || has('win32') || has('win64'))
    endfunction
  " }}}
" }}}

" fs {{{
  if WINX()
    let g:fs_sep='\'
  else
    let g:fs_sep='/'
  endif
" }}}

" basics {{{
  set nocompatible
  if !WINX()
    set shell=/bin/sh
  endif
" }}}

" fixes {{{
  if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
  endif
" }}}

