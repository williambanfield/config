call plug#begin('~/.vim/plugged')

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'rhysd/vim-go-impl'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'

" markdown editing
Plug 'shime/livedown'
Plug 'plasticboy/vim-markdown'

" language server
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

" themes :-) 
Plug 'morhetz/gruvbox'

" additional text objects and text object power
Plug 'wellle/targets.vim'

call plug#end()

let mapleader=","
syntax on
set tabstop=4
set softtabstop=4
set termguicolors
set background=dark
set autoread
set textwidth=0
set showtabline=4
set number
set cursorline
set wildmenu
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set history=1000
set iskeyword+=-
set nocp
set title
set noerrorbells
set formatoptions+=1
set virtualedit=block
set mouse=a
set showcmd

let &t_ut=''
colorscheme gruvbox
autocmd FileType go setlocal noexpandtab shiftwidth=4
autocmd FileType tex,mail,markdown,rst setlocal spell
autocmd FileType text,tex,markdown,rst setlocal tw=76
filetype plugin indent on

" allow jk to function as esc in insert and command mode
inoremap jk <esc>
cnoremap jk <esc>

let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled= 1

let g:deoplete#enable_at_startup = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1


" language client setup
let g:LanguageClient_autoStart = 0
let g:LanguageClient_serverCommands = {
    \ 'go': ['go-langserver'] }
let g:LanguageClient_diagnosticsDisplay = {
    \     1: {
    \         "name": "Error",
    \         "texthl": "ALEError",
    \         "signText": "E",
    \         "signTexthl": "ALEErrorSign",
    \     },
    \     2: {
    \         "name": "Warning",
    \         "texthl": "ALEWarning",
    \         "signText": "W",
    \         "signTexthl": "ALEWarningSign",
    \     },
    \     3: {
    \         "name": "Information",
    \         "texthl": "ALEInfo",
    \         "signText": "I",
    \         "signTexthl": "ALEInfoSign",
    \     },
    \     4: {
    \         "name": "Hint",
    \         "texthl": "ALEInfo",
    \         "signText": "➤",
    \         "signTexthl": "ALEInfoSign",
    \     },
    \ }
noremap <silent><leader> h :call LanguageClient_textDocument_hover()<CR>
noremap <silent><leader> d :call LanguageClient_textDocument_definition()<CR>
noremap <silent><leader> r :call LanguageClient_textDocument_rename()<CR>
noremap <silent><leader> s :call LanguageClient_textDocument_documentSymbol()<CR>
noremap <silent><leader> ! :LanguageClientStart<CR>

" autocomplete settings
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" edit .zshrc
nnoremap <silent><leader>ez :tabedit ~/.zsh/<CR>
" edit vimrc
nnoremap <silent><leader>ev :tabedit ~/.config/nvim/init.vim<CR>
" source vimrc
nnoremap <silent><leader>sv :so $MYVIMRC<CR>
" remove search highlighting
nnoremap <silent><space> :nohlsearch<CR>
" move visual lines
nnoremap j gj
nnoremap k gk
