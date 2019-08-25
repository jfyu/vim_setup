set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=/usr/local/opt/fzf
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
Plug 'junegunn/fzf.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'chriskempson/base16-vim'
Plug 'majutsushi/tagbar'
Plug 'christoomey/vim-tmux-navigator'
Plug 'psf/black'
Plug 'lvht/tagbar-markdown'
Plug 'lervag/vimtex'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'airblade/vim-gitgutter'

call plug#end()

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" For regular expressions turn magic on
set magic

" Enable syntax highlighting
syntax enable

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"set colour right for solarized 
"set t_Co=16

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700


" Set to auto read when a file is changed from the outside
set autoread

" Fast saving
nmap <leader>w :w!<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"change directory to the file I'm editing"
set autochdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set spell spelllang=en_ca

"set line number
set nu

"set up for atp"
"set nocp
set laststatus=2
set ruler
set wildmenu
set wildmode=longest,full

"set up for airline tab line"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ":t"
set guifont=Liberation\ Mono\ for\ Powerline\ 10
let g:airline_powerline_fonts = 1

"fix the stupid bug where VIM maximize/window split will cause the status line to disappear
set guioptions-=L

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

"To open a new empty buffer
nmap <leader>T :enew<cr>
" move to the next buffer 
nmap <leader>g :bnext<CR>
" move to the previous buffer
nmap <leader>G :bprevious<CR>
" Close the curent buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bl :ls<CR>

"Set up YCM
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
            \ 'g:ycm_python_interpreter_path',
            \ 'g:ycm_python_sys_path'
            \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
nmap <leader>gd :YcmCompleter GetDoc<CR>


" NERDTree setting
" shortcut to open NERDTree
map <C-n> :NERDTreeToggle<CR>

" set up black for automatically run on save
autocmd BufWritePre *.py execute ":Black"
let g:black_linelength=100
let g:black_virtualenv = '/usr/bin/'

" set up preview
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1
let vim_markdown_preview_temp_file=1

"change gitgutter update time
set updatetime=100
