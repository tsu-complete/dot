
let s:base=g:tsu_storage.'bundle'

let s:has_vundle=1
if !isdirectory(glob(s:base.'/Vundle.vim/'))
  exec 'silent !mkdir -p '.s:base
  exec 'silent !git clone -q'.
    \ ' https://github.com/gmarik/Vundle.vim' s:base.'/Vundle.vim'
  let s:has_vundle=0
endif

filetype off
exec 'set rtp+='.s:base.'/Vundle.vim'

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
for plugin in g:tsu_plugins
  Plugin plugin
endfor
call vundle#end()

if s:has_vundle == 0
  silent! PluginInstall
  qa
endif

call Tsu_post_plugins(s:base)

