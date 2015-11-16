
" general {{{
  set showmode
" }}}

" line numbers {{{
  set relativenumber

  autocmd InsertEnter * :set norelativenumber
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber
" }}}

" windows {{{
  set splitright
  set splitbelow
  " navigation {{{
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
  " }}}
" }}}

" tabs {{{
  set tabpagemax=15
  " navigation {{{
    map <S-H> gT
    map <S-L> gt
  " }}}
" }}}

" ruler {{{
  if has('cmdline_info')
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
  endif
" }}}

" status {{{
  if has('statusline')
    set laststatus=2
  endif
" }}}

" menu {{{
  set wildmenu
  set wildmode=list:longest,full
" }}}

" whitespace {{{
  set list
  set listchars=tab:›\ ,trail:·,extends:#,nbsp:.
" }}}

" format {{{
  set nowrap
  set autoindent
  set expandtab

  function! _set_tabsize(size)
    let g:tsu_tabsize=a:size
    let &shiftwidth=a:size
    let &tabstop=a:size
    let &softtabstop=a:size
  endfunction

  call _set_tabsize(g:tsu_tabsize)

  noremap <leader>] :call _set_tabsize(g:tsu_tabsize+1)<CR>
  noremap <leader>[ :call _set_tabsize(g:tsu_tabsize>1?g:tsu_tabsize-1:1)<CR>
" }}}

" misc {{{
  set linespace=0
  set incsearch
  set hlsearch
  set winminheight=0
  set smartcase
  set nojoinspaces
" }}}

