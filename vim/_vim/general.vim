
" general {{{
  scriptencoding utf-8
  filetype plugin indent on
  set shortmess+=filmnrxoOtT
  set foldenable
" }}}

" folding {{{
  set foldmarker={{{,}}}
  set foldlevel=0
  set foldmethod=marker
" }}}

" fixes {{{
  nnoremap Y y$
  map zl zL
  map zh zH
" }}}

" leaders {{{
  let mapleader=g:tsu_leader
  let maplocalleader=g:tsu_local_leader
" }}}

" compatibility {{{
  set viewoptions=folds,options,cursor,unix,slash
" }}}

" modes {{{
  " visual {{{
    " preserve {{{
      vnoremap < <gv
      vnoremap > >gv
      vnoremap . :normal .<CR>
    " }}}
  " }}}
" }}}

" clipboard {{{
  if has('clipboard')
    if has('unnamedplus')
      set clipboard=unnamed,unnamedplus
    else
      set clipboard=unnamed
    endif
  endif
" }}}

" buffer {{{
  if exists('g:tsu_auto_chdir')
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
  endif

  if exists('g:tsu_auto_write')
    set autowrite
  endif

  set hidden
  set backup
  if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
  endif
" }}}

" misc {{{
  set history=1000
  set spell
" }}}

