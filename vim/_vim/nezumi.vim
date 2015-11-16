
set mouse=a
set mousehide
set backspace=indent

if !exists('g:tsu_nezumi')
  finish
endif

function! NezumiEcho(message)
  echom "ネズミ・"a:message"が許可されていません"
endfunction

set mouse=

nnoremap <buffer> <Left> <Esc>:call NezumiEcho("左")<CR>
nnoremap <buffer> <Right> <Esc>:call NezumiEcho("右")<CR>
nnoremap <buffer> <Up> <Esc>:call NezumiEcho("上")<CR>
nnoremap <buffer> <Down> <Esc>:call NezumiEcho("下")<CR>
nnoremap <buffer> <PageUp> <Esc>:cal NezumiEcho("ページアップ")<CR>
nnoremap <buffer> <PageDown> <Esc>:call NezumiEcho("ページダウン")<CR>

inoremap <buffer> <Left> <Esc>:call NezumiEcho("左")<CR>
inoremap <buffer> <Right> <Esc>:call NezumiEcho("右")<CR>
inoremap <buffer> <Up> <Esc>:call NezumiEcho("上")<CR>
inoremap <buffer> <Down> <Esc>:call NezumiEcho("下")<CR>
inoremap <buffer> <PageUp> <Esc>:cal NezumiEcho("ページアップ")<CR>
inoremap <buffer> <PageDown> <Esc>:call NezumiEcho("ページダウン")<CR>

vnoremap <buffer> <Left> <Esc>:call NezumiEcho("左")<CR>
vnoremap <buffer> <Right> <Esc>:call NezumiEcho("右")<CR>
vnoremap <buffer> <Up> <Esc>:call NezumiEcho("上")<CR>
vnoremap <buffer> <Down> <Esc>:call NezumiEcho("下")<CR>
vnoremap <buffer> <PageUp> <Esc>:call NezumiEcho("ページアップ")<CR>
vnoremap <buffer> <PageDown> <Esc>:call NezumiEcho("ページダウン")<CR>

"vnoremap <buffer> h <Esc>:call NezumiEcho("h")<CR>
"vnoremap <buffer> j <Esc>:call NezumiEcho("j")<CR>
"vnoremap <buffer> k <Esc>:call NezumiEcho("k")<CR>
"vnoremap <buffer> l <Esc>:call NezumiEcho("l")<CR>
"vnoremap <buffer> - <Esc>:call NezumiEcho("-")<CR>
"vnoremap <buffer> + <Esc>:call NezumiEcho("+")<CR>

"vnoremap <buffer> gj <Esc>:call NezumiEcho("gj")<CR>
"vnoremap <buffer> gk <Esc>:call NezumiEcho("gk")<CR>
"nnoremap <buffer> gk <Esc>:call NezumiEcho("gk")<CR>
"nnoremap <buffer> gj <Esc>:call NezumiEcho("gj")<CR>

"nnoremap <buffer> h <Esc>:call NezumiEcho("h")<CR>
"nnoremap <buffer> j <Esc>:call NezumiEcho("j")<CR>
"nnoremap <buffer> k <Esc>:call NezumiEcho("k")<CR>
"nnoremap <buffer> l <Esc>:call NezumiEcho("l")<CR>
"nnoremap <buffer> - <Esc>:call NezumiEcho("-")<CR>
"nnoremap <buffer> + <Esc>:call NezumiEcho("+")<CR>

