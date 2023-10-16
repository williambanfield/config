require('lualine').setup({
	options = {
		theme = 'gruvbox',
	}
})

require('symbols-outline').setup({
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = false,
	position = 'right',
	symbols = {
		File = {icon = "", hl = "@text.uri"},
		Module = {icon = "󰆧", hl = "@namespace"},
		Namespace = {icon = "󰅪", hl = "@namespace"},
		Package = {icon = "󰏗", hl = "@namespace"},
		Class = {icon = "󰬊", hl = "@type"},
		Method = {icon = "󰰐", hl = "@method"},
		Property = {icon = "", hl = "@method"},
		Field = {icon = "󰆨", hl = "@field"},
		Constructor = {icon = "", hl = "@constructor"},
		Enum = {icon = "󰷐", hl = "@type"},
		Interface = {icon = "󰠲", hl = "@type"},
		Function = {icon = "", hl = "@function"},
		Variable = {icon = "", hl = "@constant"},
		Constant = {icon = "", hl = "@constant"},
		String = {icon = "󰅳", hl = "@string"},
		Number = {icon = "", hl = "@number"},
		Boolean = {icon = "󰬉", hl = "@boolean"},
		Array = {icon = "󰅪", hl = "@constant"},
		Object = {icon = "⦿", hl = "@type"},
		Key = {icon = "", hl = "@type"},
		Null = {icon = "󰟢", hl = "@type"},
		Operator = { icon = "+", hl = "@operator" },
		EnumMember = {icon = "", hl = "@field"},
		Struct = {icon = "󰅩", hl = "@type"},
	},
	autofold_depth = 1,
})

vim.cmd [[
  augroup OpenSymbolsOutline
    autocmd!
	autocmd BufEnter *.go lua require('symbols-outline').open_outline()

  augroup END
]]
