
" plugins {{{
  let g:tsu_plugins=[
  \ 'scrooloose/nerdtree'
  \,'scrooloose/syntastic'
  \,'bling/vim-airline'
  \,'kien/ctrlp.vim'
  \,'Shougo/unite.vim'
  \,'airblade/vim-gitgutter'
  \ ]

  function! Tsu_post_plugins(base)
    " airline {{{
      if isdirectory(a:base.'/vim-airline')
        let g:airline_left_sep = ' '
        let g:airline_right_sep = ' '
        let g:airline_mode_map = {
          \ '__' : '-'
          \,'n'  : '通常'
          \,'i'  : '挿入'
          \,'R'  : '置換'
          \,'c'  : '命令'
          \,'v'  : '見る'
          \,'V'  : '見る'
          \,'' : '見る'
          \,'s'  : '選択'
          \,'S'  : '選択'
          \,'' : '選択'
          \ }
      endif
    " }}}

    " nerdtree {{{
      if isdirectory(a:base.'/nerdtree')
        map <C-e> :NERDTreeToggle<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=0
        let NERDTreeIgnore=[
          \ '\.py[cd]$'
          \,'\~$'
          \,'\.swo$'
          \,'\.swp$'
          \,'^\.git$'
          \,'^\.hg$'
          \,'^\.svn$'
          \,'\.bzr$'
          \ ]
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
        let g:NERDTreeDirArrows = 1
        let g:NERDTreeDirArrowExpandable = '▸'
        let g:NERDTreeDirArrowCollapsible = '▾'
      endif
    " }}}

    " unite {{{
      if isdirectory(a:base.'/unite.vim')
        map <leader>bb :Unite buffer<CR>
        map <leader>m :Unite buffer<CR>
        map <leader>ff :Unite file<CR>
        map <leader>uu :Unite buffer file<CR>
        map <C-d> :Unite buffer<CR>
      endif
    "}}}
  endfunction
" }}}

" fun {{{
  " nezumi keys
  let g:tsu_nezumi=1
" }}}

" directory {{{
  " storage directory
  let g:tsu_storage=$HOME.'/.vim/'
" }}}

" keys {{{
  " leader character
  let g:tsu_leader=','
  " local leader character
  let g:tsu_local_leader='_'
" }}}

" editing {{{
  " tab size
  let g:tsu_tabsize=2
" }}}

" auto {{{
  " auto write on buffer blur
  let g:tsu_auto_write=1
  " auto switch to cwd on new buffer
  let g:tsu_auto_chdir=1
  " auto restore cursor
  let g:tsu_auto_curre=1
" }}}

