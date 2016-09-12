syntax on
set nocompatible
"colorscheme elflord
colorscheme torte

"set backspace=indent,eol,start
set bs=2
set ignorecase
"set smartcase
set hlsearch
"set incsearch  " incremental search
"set cursorline
"set number		" display line number
set ruler		" show row,col
set laststatus=2

set tabstop=4
set softtabstop=4
set shiftwidth=4
"set expandtab
set smarttab
set autoindent

"set encoding=big5
"set termencoding=utf8
"set fileencoding=utf8
"set fileencodings=utf8,cp950

" set mouse control
set mouse=
" n Normal mode  
" v Visual mode  
" i Insert mode  
" c Command-line mode  
" h all previous modes when in a help file  
" a all previous modes  
" r for |hit-enter| prompt  
" A auto-select in Visual mode

" set numpad/numberpad to input numbers
inoremap <Esc>Oq 1
inoremap <Esc>Or 2
inoremap <Esc>Os 3
inoremap <Esc>Ot 4
inoremap <Esc>Ou 5
inoremap <Esc>Ov 6
inoremap <Esc>Ow 7
inoremap <Esc>Ox 8
inoremap <Esc>Oy 9
inoremap <Esc>Op 0
inoremap <Esc>On .
inoremap <Esc>OQ /
inoremap <Esc>OR *
inoremap <Esc>Ol +
inoremap <Esc>OS -
inoremap <Esc>OM <Enter>

" Open and close all the three plugins on the same time 
nmap <F8>   :TrinityToggleAll<CR> 

" Open and close the srcexpl.vim separately 
nmap <F9>   :TrinityToggleSourceExplorer<CR> 

" Open and close the taglist.vim separately 
nmap <F10>  :TrinityToggleTagList<CR> 

" Open and close the NERD_tree.vim separately 
nmap <F11>  :TrinityToggleNERDTree<CR>

