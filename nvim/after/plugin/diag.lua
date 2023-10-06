
vim.diagnostic.config({
	virtual_text = false,
})

vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float()') 
vim.o.updatetime = 300


