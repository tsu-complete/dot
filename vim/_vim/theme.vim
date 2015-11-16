
" general {{{
  syntax on
  set nospell

  set background=dark

  function! _toggle_bg()
    let s:tbg = &background
    if s:tbg == "dark"
      set background=light
    else
      set background=dark
    endif
  endfunction
  noremap <leader>bg :call _toggle_bg()<CR>
" }}}

