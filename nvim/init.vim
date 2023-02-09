"set runtimepath^=/.vim runtimepath+=~/.vim/after

"let &packpath = &runtimepath

"source ~/.vimrc

set nocompatible "be iMproved, required
filetype off     "required

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'f-person/git-blame.nvim'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'lervag/vimtex'
"Plug 'vim-vdebug/vdebug'
Plug 'airblade/vim-gitgutter'
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
"Plug 'preservim/nerdtree'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'chriskempson/base16-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'psf/black' 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-github.nvim'
Plug 'cljoly/telescope-repo.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'liuchengxu/vista.vim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'tamton-aquib/duck.nvim'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
call plug#end()

filetype plugin indent on    " required
"enable syntax
syntax enable

"set tab
set tabstop=4 "number of visual spaces per TAB
"set softtapstop=4 "number of spaces in tab when editing
set expandtab " tabs are spaces

"UI configs
set number "show line numbers
set showcmd "show command in bottom bar
set cursorline "highlight current line
filetype indent on "load filetype-specific indent files
set wildmenu "visual autocomplete for command menu
set showmatch "highlight matching brackets

"searching
"set incsearch "search as characters are entered
set hlsearch "highlight mathces
set smartcase "smart about case
"leader
"let mapleader="-"

set termguicolors 
let base16colorspace=256
colorscheme nord
"if filereadable(expand("~/.vimrc_background"))
  "let base16colorspace=256
  "source ~/.vimrc_background
"endif

"airline display buffers when there is only one tab open"
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
"airline fonts
let g:airline_powerline_fonts= 1
"set guifont =Literation\ Mono\ Powerline:h14
set guifont =DroidSansMono\ Nerd\ Font:h11

"
"Fix backspace problem
set backspace=indent,eol,start

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>g :bnext<CR>

" Move to the previous buffer
nmap <leader>G :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" setup black for automatically run on save
augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end
" setup black to skip the double quotes and other configs
"let g:black_linelength=100
"let g:black_skip_string_normalization=1 
"enable syntax
let g:python_highlight_all = 1

"change gitgutter update time
set updatetime=100

"Set up for vim-slime
let g:slime_target='tmux'
let g:slime_default_config = {"socket_name": 'default', 'target_pane': '{right-of}'}
" fix paste issues in ipython
"let g:slime_python_ipython=1
let g:slime_bracketed_paste = 1

"NERDTree
"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTreeToggle<CR>
"nnoremap <C-t> :NERDTree<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

"Set the python hoset to conda
let g:python3_host_prog=expand('~/mambaforge/bin/python')

set completeopt=menu,menuone,noselect

"vim-rooter
"let g:rooter_cd_cmd='lcd'

"set mouse so we can use this while tmux mouse mode is on
set mouse=a

"let g:isort_command = 'isort'
"
"start git-blame
let g:gitblame_enabled = 1

"add .. to git browsing
autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

"stop adding lots of buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

"get lua 
lua require ('config')

"let g:dbs = {'wsdev': $CONN_PANTHEON}
"autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
