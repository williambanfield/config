vim.g.mapleader = ","

-- allow jk to function as esc in insert and command mode
vim.keymap.set('i', 'jk',  '<esc>', { noremap = true })
vim.keymap.set('c', 'jk',  '<esc>', { noremap = true })
-- move visual lines
vim.keymap.set('n', 'j',  'gj', { noremap = true })
vim.keymap.set('n', 'k',  'gk', { noremap = true })
	
-- edit .zshrc
vim.keymap.set('n', '<leader>ez', ':tabedit ~/.zsh/<CR>', { silent=true, noremap=true })
-- edit vimrc
vim.keymap.set('n', '<leader>ev', ':tabedit ~/.config/nvim/init.lua<CR>', { silent=true, noremap=true })

-- source vimrc
vim.keymap.set('n', '<leader>sv', ':so $MYVIMRC<CR>', { noremap = true, silent=true })
-- clear out search highlighting
vim.keymap.set('n', '<space>', ':nohlsearch<CR>', { noremap = true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>im', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]], {noremap=true, silent=true})

-- Search and replace hovered word
vim.api.nvim_set_keymap('n', '<leader>s', [[:.,$s/\<<C-r><C-w>\>//gc<Left><Left><Left>]], { noremap = true, silent = false })

-- Search and replace highlighted text
vim.api.nvim_set_keymap('x', '<leader>s', [[y:.,$s/<C-r>"//gc<Left><Left><Left>]], { noremap = true, silent = false })
