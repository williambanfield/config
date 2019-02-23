autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType tex,mail,markdown,rst setlocal spell
autocmd FileType text,tex,markdown,rst setlocal tw=76
syntax on
filetype plugin indent on
set nu 


call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'shime/livedown'
Plug 'rhysd/vim-go-impl'
Plug 'plasticboy/vim-markdown'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
call plug#end()

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
noremap <silent> ,h :call LanguageClient_textDocument_hover()<CR>
noremap <silent> ,d :call LanguageClient_textDocument_definition()<CR>
noremap <silent> ,r :call LanguageClient_textDocument_rename()<CR>
noremap <silent> ,s :call LanguageClient_textDocument_documentSymbol()<CR>
noremap <silent> ,! :LanguageClientStart<CR>


inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


let g:deoplete#enable_at_startup = 1
let g:go_fmt_command = "goimports"
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
