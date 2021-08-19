call plug#begin('~/.vim/plugged')

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

" fuzzy finder
Plug 'junegunn/fzf'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" rust 
Plug 'rust-lang/rust.vim'

" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'rhysd/vim-go-impl'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'prabirshrestha/async.vim'

" markdown editing
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'


" rst files
Plug 'gu-fan/riv.vim'

" language server
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

Plug 'avakhov/vim-yaml'

" themes :-) 
Plug 'morhetz/gruvbox'

" additional text objects and text object power
Plug 'wellle/targets.vim'

Plug 'uber/prototool', { 'rtp':'vim/prototool' }
call plug#end()

let mapleader=","
syntax on
set tabstop=4
set colorcolumn=80
set softtabstop=4
set termguicolors
set background=dark
set t_Co=256
set autoread
set textwidth=0
set showtabline=4
set nu
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
set autoindent
set smartindent
set shiftwidth=4
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:_
set list
set noswapfile 


filetype plugin indent on

let &t_ut=''
colorscheme gruvbox

" allow jk to function as esc in insert and command mode
inoremap jk <esc>
cnoremap jk <esc>

" move visual lines
nnoremap j gj
nnoremap k gk

" airline configuration
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled= 1

" fzf configuration
nnoremap <C-p> :FZF<CR>
let g:fzf_nvim_statusline=0

" disable ugly status line when using fzf
" taken from: https://github.com/junegunn/fzf.vim#status-line-of-terminal-buffer
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus showmode ruler


" language client configuration 
let g:LanguageClient_autoStart = 0
let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
    \ 'rust': ['rls']}

let g:LanguageClient_useVirtualText = "No"

let g:vmt_auto_update_on_save = 0
let g:vmt_dont_insert_fence = 1


"let g:LanguageClient_diagnosticsDisplay= {
"      \   1: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
"      \   2: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
"      \   3: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
"      \   4: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
"      \ }

noremap <silent><leader>h :call LanguageClient_textDocument_hover()<CR>
noremap <silent><leader>d :call LanguageClient_textDocument_definition()<CR>
noremap <silent><leader>r :call LanguageClient_textDocument_rename()<CR>
noremap <silent><leader>s :call LanguageClient_textDocument_documentSymbol()<CR>
noremap <silent><leader>! :LanguageClientStart<CR>

" autocomplete settings
" deoplete configuration
let g:deoplete#enable_at_startup = 1
" disable deoplete from opening up documentation
set completeopt-=preview

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" --- bindings for convenience --- 
" edit .zshrc
nnoremap <silent><leader>ez :tabedit ~/.zsh/<CR>
" edit vimrc
nnoremap <silent><leader>ev :tabedit ~/.config/nvim/init.vim<CR>
" source vimrc
nnoremap <silent><leader>sv :so $MYVIMRC<CR>
" clear out search highlighting
nnoremap <silent><space> :nohlsearch<CR>

" --- Filetype specific configuration --- 

" rust file configurations
let g:rustfmt_autosave = 1

" go file configuration
let g:go_fmt_command = "goimports"
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_auto_type_info = 1 
let g:go_auto_sameids = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

autocmd FileType go setlocal noexpandtab shiftwidth=4
autocmd Filetype go noremap <silent><leader>ge :GoIfErr<CR>

" terraform on save format
let g:terraform_fmt_on_save=1

" disable folding in markdown
let g:vim_markdown_folding_disabled = 1

" format proto on save
autocmd Filetype proto :call PrototoolFormatOnSave()
nnoremap <silent> <leader>f :call PrototoolFormatFix()<CR>



" set up a colorcolumn
au Filetype rust set colorcolumn=100

" set spell checking for mail/markdown/rst/tex files
autocmd FileType tex,mail,markdown,rst setlocal spell
