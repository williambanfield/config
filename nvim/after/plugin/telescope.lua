vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ft', '<cmd>Telescope treesitter<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope git_commits<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope registers<cr>', { noremap = true, silent = true })

