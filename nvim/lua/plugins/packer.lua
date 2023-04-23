vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	-- manager packer installation
	use 'wbthomason/packer.nvim'

	-- git
	use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-rhubarb'
	
	-- fuzzy finder
	use {'junegunn/fzf', run =function() vim.fn['fzf#install'](0)  end}
	use 'junegunn/fzf.vim'
	
	-- airline
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	
	-- rust
	use 'rust-lang/rust.vim'
	
	-- golang
	use { 'fatih/vim-go',  run =  ':GoUpdateBinaries' }
	use 'rhysd/vim-go-impl'
	
	-- snippits
	use 'SirVer/ultisnips'
	use 'quangnguyen30192/cmp-nvim-ultisnips'
	
	-- autocomplete
	use 'prabirshrestha/async.vim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	
	-- language server
	use 'neovim/nvim-lspconfig'
	
	-- markdown editing
	use { 'instant-markdown/vim-instant-markdown', ft = 'markdown', run = 'yarn install' }
	use 'plasticboy/vim-markdown'
	use 'mzlogin/vim-markdown-toc'
	
	-- rst files
	use 'gu-fan/riv.vim'
	
	-- AST generation
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use { 'nvim-treesitter/playground', run = ':TSUpdate'}
	
	use 'easymotion/vim-easymotion'
	use 'tpope/vim-surround'
	
	-- themes :-) 
	use 'morhetz/gruvbox'
	
	-- additional text objects and text object power
	use 'wellle/targets.vim'
	
	use {'uber/prototool', rtp = 'vim/prototool' }
	
	use 'hashivim/vim-terraform'
	
	-- experimental
	-- these are plugins I'm trying out that I'm not sure if I like!
	use 'nvim-lua/plenary.nvim'
	use {'nvim-telescope/telescope.nvim', tag =  '0.1.1' }
	
	use 'github/copilot.vim'

end)
