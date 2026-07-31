-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- git
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local opts = { buffer = bufnr }
					vim.keymap.set('n', ']c', gs.next_hunk, opts)
					vim.keymap.set('n', '[c', gs.prev_hunk, opts)
					vim.keymap.set('n', '<leader>cs', gs.stage_hunk, opts)
					vim.keymap.set('n', '<leader>cu', gs.undo_stage_hunk, opts)
					vim.keymap.set('n', '<leader>cr', gs.reset_hunk, opts)
					vim.keymap.set('n', '<leader>cp', gs.preview_hunk, opts)
					vim.keymap.set('n', '<leader>cb', gs.blame_line, opts)
				end
			})
		end
	},

	-- fuzzy finder
	{ 'junegunn/fzf', build = function() vim.fn['fzf#install'](0) end },
	'junegunn/fzf.vim',

	-- statusline
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},

	-- rust
	'rust-lang/rust.vim',

	-- golang
	{
		'edolphin-ydf/goimpl.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-lua/popup.nvim',
			'nvim-telescope/telescope.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			pcall(require('telescope').load_extension, 'goimpl')
		end,
	},
	'AndrewRadev/splitjoin.vim',

	-- autocomplete
	'prabirshrestha/async.vim',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-buffer',
	-- language server
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
		},
	},

	-- markdown
	{ 'instant-markdown/vim-instant-markdown', ft = 'markdown', build = 'yarn install' },
	'plasticboy/vim-markdown',
	'mzlogin/vim-markdown-toc',

	-- rst
	'gu-fan/riv.vim',

	-- treesitter (pinned to master for pre-compiled parser support)
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'master',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = { 'go', 'bash' },
				sync_install = false,
				auto_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
			})
		end,
	},

	{ 'numToStr/Comment.nvim', config = function() require('Comment').setup() end },

	'easymotion/vim-easymotion',
	'tpope/vim-surround',

	-- themes
	'morhetz/gruvbox',
	'ku1ik/vim-monokai',

	-- text objects
	'wellle/targets.vim',

	{ 'uber/prototool', rtp = 'vim/prototool' },

	'hashivim/vim-terraform',
	'tpope/vim-unimpaired',

	-- telescope
	'nvim-lua/plenary.nvim',
	'nvim-telescope/telescope.nvim',

	-- gp.nvim (AI)
	{
		'robitx/gp.nvim',
		config = function()
			require("gp").setup()
		end,
	},

	-- which-key
	{
		'folke/which-key.nvim',
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},

	'jghauser/mkdir.nvim',


	{
		'j-hui/fidget.nvim',
		tag = 'legacy',
	},
})
