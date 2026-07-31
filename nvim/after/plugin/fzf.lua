vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git"'
vim.keymap.set('n', '<C-p>', ':FZF<CR>')
vim.keymap.set('n', '<C-s>', ':Rg<CR>')
vim.keymap.set('n', '<C-l>', ':Lines<CR>')
vim.keymap.set('n', '<C-b>', ':Buffer!<CR>')
vim.keymap.set('n', '<C-e>', ':GFiles?<CR>')
vim.g.fzf_nvim_statusline=0
