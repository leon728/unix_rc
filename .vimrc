" :set number      Turn line numbers on
" :set nonumber    Turn line numbers off
" :set invnumber   Toggle line numbers
" :set number!     Toggle line numbers
" :set number&     Set option to default value
" :set number?     Show value of option

syntax on
set nocompatible
colorscheme desert
"colorscheme koehler
"colorscheme pablo
"colorscheme slate

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

set list
set listchars=tab:▸\ ,trail:●

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
"set mouse=a
"set mouse=ni
" n Normal mode  
" v Visual mode  
" i Insert mode  
" c Command-line mode  
" h all previous modes when in a help file  
" a all previous modes  
" r for |hit-enter| prompt  
" A auto-select in Visual mode

"set t_Co=256
"set t_Co=16
"set t_Co=8
highlight LineNr ctermfg=245 ctermbg=235

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

"nmap <F8>   :TrinityToggleAll<CR> 
"nmap <F9>   :TrinityToggleSourceExplorer<CR> 
"nmap <F10>  :TrinityToggleTagList<CR> 
"nmap <F11>  :TrinityToggleNERDTree<CR>

map <F2> <ESC>:set paste!<CR>
map <F3> <ESC>:exec &mouse!="" ? "set mouse=" : "set mouse=a"<CR>
"map <F4> <ESC>:set invnumber<CR>
map <F4> <ESC>:set number!<CR>

nmap <C-P> :Files<CR>
nmap <F9>  :NERDTreeToggle<CR>
nmap <F10> :TagbarToggle<CR>

" https://vim.fandom.com/wiki/Easier_buffer_switching#Switching_by_number
nmap <F5>  :Buffers<CR>
nmap <C-J> :bp<CR>
nmap <C-K> :bn<CR>
":bd  buffer delete

" https://vim.fandom.com/wiki/Improved_hex_editing
"nnoremap <C-H> :Hexmode<CR>
"inoremap <C-H> <Esc>:Hexmode<CR>
"vnoremap <C-H> :<C-U>Hexmode<CR>

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
"Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'fholgado/minibufexpl.vim'
"Plug 'ap/vim-buftabline'
"Plug 'itchyny/lightline.vim'
"Plug 'pacha/vem-tabline'
"Plug 'vim-scripts/BufLine'
"Plug 'zefei/vim-wintabs'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'fidian/hexmode'
Plug 'google/vim-searchindex'

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'antoinemadec/coc-fzf'
"Plug 'yggdroot/leaderf'
"Plug 'kien/ctrlp.vim'

" Initialize plugin system
call plug#end()

"let g:airline_extensions = []
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tagbar#enabled = 0
let g:airline_section_b = ''
"let g:airline_section_z = '%p%% %l/%L:%v'
let g:airline_section_z = '%l:%v %p%%'
"let g:airline_section_error
let g:airline_section_warning = ''
