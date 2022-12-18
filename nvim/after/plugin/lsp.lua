local on_attach = function(client, bufnr) 
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, nil)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, nil)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, nil)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, nil)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['gopls'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}

require('lspconfig')['bashls'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}
