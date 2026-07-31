require("mason").setup()

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local bufopts = { noremap=true, silent=true, buffer=args.buf }
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		vim.keymap.set('n', 'gtd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts)
	end
})

vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('gopls', {
	settings = {
		gopls = {
			buildFlags = {"-tags=cluster_integration"},
		},
	},
})

vim.lsp.enable({'gopls', 'bashls', 'ts_ls', 'eslint', 'pylsp', 'lua_ls', 'buf_ls', 'starpls'})

-- Use Neovim's built-in signature help (lsp_signature.nvim crashes treesitter on 0.12)
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('SignatureHelp', { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method('textDocument/signatureHelp') then
			vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = args.buf })
		end
	end,
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

        local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")

        local formatted_content = vim.fn.system("shfmt -i 2 --binary-next-line --space-redirects", content)

        if vim.v.shell_error ~= 0 then
            vim.api.nvim_err_writeln("shfmt error: " .. formatted_content)
            return
        end

        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(formatted_content, "\n"))
        vim.bo[bufnr].eol = false
        vim.bo[bufnr].fixeol = false
    end
})

vim.api.nvim_create_augroup('GoFmtOnSave', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'GoFmtOnSave',
    pattern = '*.go',
    callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })
        if #clients == 0 then return end
        local client = clients[1]
        if not client.initialized then return end

        local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 3000)
        for _, res in pairs(result or {}) do
            for _, action in pairs(res.result or {}) do
                if action.edit then
                    vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                end
            end
        end

        vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 3000, async = false })
    end
})

vim.api.nvim_create_augroup('ClangFormatOnSave', { clear = true })
