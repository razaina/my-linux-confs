let mapleader=","
syntax enable
set rtp+=~/.vim/bundle/vundle/
set nocompatible
syntax on
colorscheme desert
set background=dark
set encoding=utf8
set hlsearch
set history=700
filetype plugin on
filetype indent on
set autoread
set ruler
set ignorecase
set smartcase
set incsearch
set magic
set showmatch
set mat=2
set ffs=unix,dos,mac
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set number

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
set cursorline
highlight CursorLine guibg=#000100
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'

"Comments
map <C-c> s:NERDComComment<CR>


"easy-motion configuration
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

"nerdtree auto open while file openned
"autocmd vimenter * NERDTree
"run nerdtree
map <C-n> :NERDTreeToggle<CR>
"auto close 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


