syntax enable
set list
set mouse=a
set foldlevel=99
set rtp+=~/.vim/bundle/vundle/
set laststatus=2
set nocompatible
syntax on
colorscheme delek
set t_Co=256 "tell the term has 256 colors
set hidden "hide buffers when not displayed
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

"let g:vim_debug_disable_mappings= 1
"let g:ycm_extra_conf_vim_data=['v:version'] 
"let g:ycm_colect_identifiers_from_tags_files=1
"let g:ycm_seed_identifiers_with_syntax=1
"let g:ycm_add_preview_to_completeopt=1
"let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist=1

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
Bundle 'davidhalter/jedi-vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'bling/vim-airline'
Bundle 'majutsushi/tagbar'
Bundle 'jdonaldson/vaxe'

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

set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
set iskeyword+=:
set textwidth=100
hi User1 ctermbg=green ctermfg=red   guibg=green guifg=red
hi User2 ctermbg=red   ctermfg=blue  guibg=red   guifg=blue
hi User3 ctermbg=blue  ctermfg=green guibg=blue  guifg=green
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
""statusline setup
"set statusline =%#identifier#
"set statusline+=[%t] "tail of the filename
"set statusline+=%*

""display a warning if fileformat isnt unix
"set statusline+=%#warningmsg#
"set statusline+=%{&ff!='unix'?'['.&ff.']':''}
"set statusline+=%*

""display a warning if file encoding isnt utf-8
"set statusline+=%#warningmsg#
"set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
"set statusline+=%*

"set statusline+=%h "help file flag
"set statusline+=%y "filetype

""read only flag
"set statusline+=%#identifier#
"set statusline+=%r
"set statusline+=%*

""modified flag
"set statusline+=%#identifier#
"set statusline+=%m
"set statusline+=%*

"set statusline+=%{fugitive#statusline()}

""display a warning if &et is wrong, or we have mixed-indenting
"set statusline+=%#error#
"set statusline+=%{StatuslineTabWarning()}
"set statusline+=%*

"set statusline+=%{StatuslineTrailingSpaceWarning()}

"set statusline+=%{StatuslineLongLineWarning()}
"let g:statline_syntastic=0
"set statusline+=%#warningmsg#
""set statusline+=%{SyntasticStatuslineFlag()}
""set statusline+=%*

""display a warning if &paste is set
"set statusline+=%#error#
"set statusline+=%{&paste?'[paste]':''}
"set statusline+=%*

"set statusline+=%= "left/right separator
"set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
"set statusline+=%c, "cursor column
"set statusline+=%l/%L "cursor line/total lines
"set statusline+=\ %P "percent through file
"set laststatus=2


""recalculate the trailing whitespace warning when idle, and after saving
"autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

""return '[\s]' if trailing white space is detected
""return '' otherwise
"function! StatuslineTrailingSpaceWarning()
    "if !exists("b:statusline_trailing_space_warning")

        "if !&modifiable
            "let b:statusline_trailing_space_warning = ''
            "return b:statusline_trailing_space_warning
        "endif

        "if search('\s\+$', 'nw') != 0
            "let b:statusline_trailing_space_warning = '[\s]'
        "else
            "let b:statusline_trailing_space_warning = ''
        "endif
    "endif
    "return b:statusline_trailing_space_warning
"endfunction


""return the syntax highlight group under the cursor ''
"function! StatuslineCurrentHighlight()
    "let name = synIDattr(synID(line('.'),col('.'),1),'name')
    "if name == ''
        "return ''
    "else
        "return '[' . name . ']'
    "endif
"endfunction

""recalculate the tab warning flag when idle and after writing
"autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

""return '[&et]' if &et is set wrong
""return '[mixed-indenting]' if spaces and tabs are used to indent
""return an empty string if everything is fine
"function! StatuslineTabWarning()
    "if !exists("b:statusline_tab_warning")
        "let b:statusline_tab_warning = ''

        "if !&modifiable
            "return b:statusline_tab_warning
        "endif

        "let tabs = search('^\t', 'nw') != 0

""find spaces that arent used as alignment in the first indent column
        "let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        "if tabs && spaces
            "let b:statusline_tab_warning = '[mixed-indenting]'
        "elseif (spaces && !&et) || (tabs && &et)
            "let b:statusline_tab_warning = '[&et]'
        "endif
    "endif
    "return b:statusline_tab_warning
"endfunction

""recalculate the long line warning when idle and after saving
"autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

""return a warning for "long lines" where "long" is either &textwidth or 80 (if
""no &textwidth is set)
""
""return '' if no long lines
""return '[#x,my,$z] if long lines are found, were x is the number of long
""lines, y is the median length of the long lines and z is the length of the
""longest line
"function! StatuslineLongLineWarning()
    "if !exists("b:statusline_long_line_warning")

        "if !&modifiable
            "let b:statusline_long_line_warning = ''
            "return b:statusline_long_line_warning
        "endif

        "let long_line_lens = s:LongLines()

        "if len(long_line_lens) > 0
            "let b:statusline_long_line_warning = "[" .
                        "\ '#' . len(long_line_lens) . "," .
                        "\ 'm' . s:Median(long_line_lens) . "," .
                        "\ '$' . max(long_line_lens) . "]"
        "else
            "let b:statusline_long_line_warning = ""
        "endif
    "endif
    "return b:statusline_long_line_warning
"endfunction

""return a list containing the lengths of the long lines in this buffer
"function! s:LongLines()
    "let threshold = (&tw ? &tw : 80)
    "let spaces = repeat(" ", &ts)
    "let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    "return filter(line_lens, 'v:val > threshold')
"endfunction

""find the median of the given array of numbers
"function! s:Median(nums)
    "let nums = sort(a:nums)
    "let l = len(nums)

    "if l % 2 == 1
        "let i = (l-1) / 2
        "return nums[i]
    "else
        "return (nums[l/2] + nums[(l/2)-1]) / 2
    "endif
"endfunction

""nerdtree settings
"let g:NERDTreeMouseMode = 2
"let g:NERDTreeWinSize = 40

""explorer mappings
"nnoremap <f1> :BufExplorer<cr>
"nnoremap <f2> :NERDTreeToggle<cr>
"nnoremap <f3> :TagbarToggle<cr>

""source project specific config files
"runtime! projects/**/*.vim

""dont load csapprox if we no gui support - silences an annoying warning
"if !has("gui")
    "let g:CSApprox_loaded = 1
"endif

""make <c-l> clear the highlight as well as redraw
"nnoremap <C-L> :nohls<CR><C-L>
"inoremap <C-L> <C-O>:nohls<CR>

""map Q to something useful
"noremap Q gq

""make Y consistent with C and D
"nnoremap Y y$

""visual search mappings
"function! s:VSetSearch()
    "let temp = @@
    "norm! gvy
    "let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    "let @@ = temp
"endfunction
"vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
"vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


""jump to last cursor position when opening a file
""dont do it when writing a commit log entry
"autocmd BufReadPost * call SetCursorPosition()
"function! SetCursorPosition()
    "if &filetype !~ 'svn\|commit\c'
        "if line("'\"") > 0 && line("'\"") <= line("$")
            "exe "normal! g`\""
            "normal! zz
        "endif
    "end
"endfunction

""spell check when writing commit logs
"autocmd filetype svn,*commit* setlocal spell

"http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"hacks from above (the url, not jesus) to delete fugitive buffers when we
"leave them - otherwise the buffer list gets poluted
"
"add a mapping on .. to view parent tree
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \ nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

set tags+=~/.vim/tags/stl      
set tags+=~/.vim/tags/gl      
set tags+=~/.vim/tags/qt4      

" OmniCppComplete      
"let OmniCpp_NamespaceSearch = 1      
"let OmniCpp_GlobalScopeSearch = 1      
"let OmniCpp_ShowAccess = 1      
"let OmniCpp_MayCompleteDot = 1      
"let OmniCpp_MayCompleteArrow = 1      
"let OmniCpp_MayCompleteScope = 1      
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]     

set completeopt=menuone,menu,longest,preview

" build tags of your own project with CTRL+F12      
" "map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>      
noremap <F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>      
inoremap <F11> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>   
runtime! ftplugin/man.vim
map <F2> :YcmCompleter GoToDeclaration<CR>
map <F3> :e#<CR>
map <F5> :make \| copen<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#eft_alt_sep = '|'
let g:airline_theme='simple'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"

"TAGBAR
nmap <F8> :TagbarToggle<CR>
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
