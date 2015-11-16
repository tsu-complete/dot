
" commit {{{
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
" }}}

" mergeconflict {{{
  map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" }}}

