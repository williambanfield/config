vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use) -- manager packer installation
	use 'wbthomason/packer.nvim'

	-- git
	use 'tpope/vim-fugitive'
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-rhubarb'
	
	-- fuzzy finder
	use {'junegunn/fzf', run =function() vim.fn['fzf#install'](0)  end}
	use 'junegunn/fzf.vim'
	
	-- airline
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
	
	-- rust
	use 'rust-lang/rust.vim'
	
	-- golang
	use { 'fatih/vim-go',  run =  ':GoUpdateBinaries' }
	use 'rhysd/vim-go-impl'
	use {
		'edolphin-ydf/goimpl.nvim',
		requires = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-lua/popup.nvim'},
			{'nvim-telescope/telescope.nvim', tag = '0.1.4' },
			{'nvim-treesitter/nvim-treesitter'},
		},
		config = function()
			require'telescope'.load_extension'goimpl'
		end,
	}
	use { 'AndrewRadev/splitjoin.vim' }
	
	-- snippits
	use 'SirVer/ultisnips'
	use 'quangnguyen30192/cmp-nvim-ultisnips'
	
	-- autocomplete
	use 'prabirshrestha/async.vim'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'ray-x/lsp_signature.nvim'

	-- language server
	use { 'neovim/nvim-lspconfig',
		requires = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
	}
	
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
	use 'ku1ik/vim-monokai'
	
	-- additional text objects and text object power
	use 'wellle/targets.vim'
	
	use {'uber/prototool', rtp = 'vim/prototool' }
	
	use 'hashivim/vim-terraform'

	use 'tpope/vim-unimpaired'
	
	-- experimental
	-- these are plugins I'm trying out that I'm not sure if I like!
	use 'nvim-lua/plenary.nvim'
	use {'nvim-telescope/telescope.nvim'}
	

	use({
		"robitx/gp.nvim",
		config = function()
				require("gp").setup()
		end
	})
	use {
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end
	}
	use 'jghauser/mkdir.nvim'
	use {
	"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = { 
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}
	use {
		'j-hui/fidget.nvim',
		tag = 'legacy',
		config = function()
		end
	}


end)
