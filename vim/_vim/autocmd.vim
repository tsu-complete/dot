
" prewrite {{{
  function! _prewrite()
    let search=@/
    let position=getpos(".")

    silent! %s#\($\n\s*\)\+\%$## " remove all newlines at EOF
    silent! %s#\%$#\r#           " add a single newline at EOF
    silent! %s#\%^\($\n\s*\)\+## " remove all newlines at BOF
    silent! %s#\%^#\r#           " add a single newline at BOF
    silent! %s#\%^\n\#!#\#!#     " repair shebangs
    silent! %s#\s\+$##           " remove all trailing spaces

    let @/=search
    call setpos('.', position)
  endfunction
  autocmd BufWritePre * call _prewrite()
" }}}

" file types fixes {{{
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
  autocmd BufNewFile,BufRead *.zsh-theme set filetype=zsh
  autocmd BufNewFile,BufRead *.md set filetype=markdown
" }}}

