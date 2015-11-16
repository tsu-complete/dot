
" general {{{
  "set cursorline
  highlight clear SignColumn
  highlight clear LineNr
" }}}

" mouse {{{
  set mouse=a
  set mousehide
" }}}

" restore {{{
  if exists('g:tsu_auto_curre')
    function! _restore_cursor()
      if line("'\"") <= line("$")
        silent! normal! g`"
        return 1
      endif
    endfunction

    augroup restore_cursor
      autocmd!
      autocmd BufWinEnter * call _restore_cursor()
    augroup END
  endif
" }}}

" eow {{{
  set iskeyword-=.
  set iskeyword-=#
  set iskeyword-=-
" }}}

" scroll {{{
  set scrolljump=5
  set scrolloff=3
" }}}

" wrapping {{{
  " navigation {{{
    noremap j gj
    noremap k gk

    function! _wrap_relative(key, ...)
      let sel=""
      if a:0
        let sel="gv"
      endif
      if &wrap
        execute "normal!" sel . "g" . a:key
      else
        execute "normal!" sel . a:key
      endif
    endfunction

    noremap $ :call _wrap_relative("$")<CR>
    noremap <End> :call _wrap_relative("$")<CR>
    noremap 0 :call _wrap_relative("0")<CR>
    noremap <Home> :call _wrap_relative("0")<CR>
    noremap ^ :call _wrap_relative("^")<CR>

    onoremap $ v:call _wrap_relative("$")<CR>
    onoremap <End> v:call _wrap_relative("$")<CR>

    vnoremap $ :<C-U>call _wrap_relative("$", 1)<CR>
    vnoremap <End> :<C-U>call _wrap_relative("$", 1)<CR>
    vnoremap 0 :<C-U>call _wrap_relative("0", 1)<CR>
    vnoremap <Home> :<C-U>call _wrap_relative("0", 1)<CR>
    vnoremap ^ :<C-U>call _wrap_relative("^", 1)<CR>
  " }}}
" }}}

" misc {{{
  set virtualedit=onemore
  set backspace=indent,eol,start
  set whichwrap=b,s,h,l,<,>,[,]
  set showmatch
" }}}

