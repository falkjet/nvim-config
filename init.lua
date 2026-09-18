-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.wo.relativenumber = true
vim.wo.number = true
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.shiftwidth = 0
vim.o.tabstop = 4
vim.o.exrc = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.opt.lispoptions:append("expr:1")

require("config.lazy") -- Bootstrap lazy
vim.cmd.colorscheme("tokyonight")

require("config.folding")


--- custom commands (lsp mostly)
local command = vim.api.nvim_create_user_command
command("LspRename", function() return vim.lsp.buf.rename() end, {})
command("LspDefinition", function() return vim.lsp.buf.definition() end, {})
command("LspAction", function() return vim.lsp.buf.code_action() end, {})
command("LspRestart", function() return vim.cmd.lsp("restart") end, {})
command("LspFormat", function() return vim.lsp.buf.format() end, {})
command("LspImplementation", function() return vim.lsp.buf.implementation() end, {})

-- Diagnostic
vim.diagnostic.config {
	virtual_text = true
}

--- Lsps
vim.lsp.enable("gopls")
vim.lsp.enable("zls")
vim.lsp.enable("pylsp")

vim.filetype.add {
	extension = {
		cshtml = "razor",
		maude = "maude",
		templ = "templ",
		tmpl = "gohtmltmpl",
		bqn = "bqn",
		cmp = "compila",
		nl = "nomenlang",
	},
}

-- Fix words automatically
vim.cmd("Abolish challang{e,es,ing,ed,er} challeng{}")
vim.cmd("Abolish stirng string")
vim.cmd("Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}")
vim.cmd("Abolish ambiguoes ambiguous")
vim.cmd("Abolish ambiguos ambiguous")
vim.keymap.set("n", "<leader>l",function() return vim.cmd.Lexicon(vim.fn.expand("<cword>")) end, {})

-- Templ
vim.cmd("autocmd BufWritePost *.templ silent! !templ generate %")
