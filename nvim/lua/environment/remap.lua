vim.g.mapleader = ","

-- allow jk to function as esc in insert and command mode
vim.keymap.set('i', 'jk',  '<esc>', { noremap = true })
vim.keymap.set('c', 'jk',  '<esc>', { noremap = true })
-- move visual lines
vim.keymap.set('n', 'j',  'gj', { noremap = true })
vim.keymap.set('n', 'k',  'gk', { noremap = true })
	
-- edit .zshrc
vim.keymap.set('n', '<silent><leader>ez', ':tabedit ~/.zsh/<CR>')
-- edit vimrc
vim.keymap.set('n', '<silent><leader>ev', ':tabedit ~/.config/nvim/init.lua<CR>')
-- source vimrc
vim.keymap.set('n', '<silent><leader>sv', ':so $MYVIMRC<CR>', { noremap = true })
-- clear out search highlighting
vim.keymap.set('n', '<silent><space>', ':nohlsearch<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>im', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]], {noremap=true, silent=true})

