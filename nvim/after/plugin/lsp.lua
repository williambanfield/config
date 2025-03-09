require("mason").setup()

local on_attach = function(client, bufnr) 
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, nil)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, nil)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, nil)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, nil)


	local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gtd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['gopls'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = {
		gopls = {
		buildFlags =  {"-tags=cluster_integration"},
	},
	},
}

require('lspconfig')['bashls'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}

require('lspconfig')['ts_ls'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}

require('lspconfig')['eslint'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}

require('lspconfig')['pylsp'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}

require('lspconfig')['lua_ls'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}

require('lspconfig')['bufls'].setup{
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities
}

require('lsp_signature').setup({
	bind = true,
	handler_opts = {
		border = "rounded"
	}
})

vim.api.nvim_create_augroup('EslintOnSave', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'EslintOnSave',
    pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
    callback = function()
        vim.cmd('EslintFixAll')
    end
})

vim.api.nvim_create_augroup('ShfmtOnSave', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'ShfmtOnSave',
    pattern = { '*.sh', '*.bash', '*.zsh' },
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Get buffer contents
        local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")

        -- Run shfmt on the buffer content
        local formatted_content = vim.fn.system("shfmt -i 2 --binary-next-line --space-redirects", content)

        -- Check for errors in shfmt output
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_err_writeln("shfmt error: " .. formatted_content)
            return
        end

        -- Replace buffer content with formatted content
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(formatted_content, "\n"))
        -- Ensure no newline is added at the end
        vim.bo[bufnr].eol = false
        vim.bo[bufnr].fixeol = false
    end
})

vim.api.nvim_create_augroup('ClangFormatOnSave', { clear = true })
