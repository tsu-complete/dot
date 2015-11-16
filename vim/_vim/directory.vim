
" init {{{
  function! _dir_init()
    let parent=$HOME
    let prefix='vim_'
    let dir_list = {
      \  'backup':'backupdir'
      \, 'views':'viewdir'
      \, 'swap':'directory'
      \ }
    if has('persistent_undo')
      let dir_list['undo']='undodir'
    endif
    let common_dir = g:tsu_storage . prefix

    for [dirname, settingname] in items(dir_list)
      let dir = common_dir . dirname . '/'
      if exists("*mkdir")
        if !isdirectory(dir)
          call mkdir(dir)
        endif
      endif
      if !isdirectory(dir)
        echo "WARN: invalid storage directory"
        echo "      try: `mkdir -p ".dir."`"
      else
        let dir=substitute(dir," ","\\\\ ","g")
        exec "set ".settingname."=".dir
      endif
    endfor
  endfunction

  call _dir_init()
" }}}
