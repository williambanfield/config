vim.g.mapleader=","
---noremap \ ,
vim.opt.syntax=on
vim.opt.tabstop=4
vim.opt.colorcolumn="80"
vim.opt.softtabstop=4
vim.opt.termguicolors=true
vim.opt.background="dark"
vim.opt.autoread=true
vim.opt.textwidth=0
vim.opt.showtabline=4
vim.opt.nu=true
vim.opt.cursorline=true
vim.opt.wildmenu=true
vim.opt.showmatch=true
vim.opt.incsearch=true
vim.opt.hlsearch=true
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.history=1000
vim.opt.iskeyword:append("-")
vim.opt.title=true
vim.opt.formatoptions:append("1")
vim.opt.virtualedit="block"
vim.opt.mouse="a"
vim.opt.showcmd=true
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.shiftwidth=4
vim.opt.listchars={eol='¬',tab='>·',trail='~',extends='>',precedes='<',space='_'}
vim.opt.list=true
vim.opt.swapfile=false
vim.opt.shortmess:remove("F")
vim.opt.statusline = "%F"
vim.g.vim_markdown_folding_disabled=1


-- Open the directory of the current file
vim.api.nvim_create_user_command("Dir", function(opts)
    vim.cmd('edit ' .. vim.fn.expand('%:p:h'))
end, {})

vim.api.nvim_create_user_command("RRoot", function(opts)
    local output = vim.fn.systemlist("git rev-parse --show-toplevel")
    vim.cmd('edit ' .. output[1])
end, {})

vim.api.nvim_create_user_command("RgHere", function(opts)
    local local_dir = vim.fn.expand('%:h')
    if local_dir == "." then
        local_dir = ""
    end
    local cmd = string.format("rg --column --line-number --no-heading --color=always -g'%s/**' --smart-case -- %s", local_dir, vim.fn.shellescape(opts.args))
    local is_bang = 0
  
    vim.fn["fzf#vim#grep"](cmd, vim.fn["fzf#vim#with_preview"](), is_bang)
  end, {
    nargs = "*",
    desc = "Search the directory of the current file with ripgrep + fzf"
  })
