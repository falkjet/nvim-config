-- [nfnl] init.fnl
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
require("config.lazy")
vim.cmd.colorscheme("tokyonight")
require("config.folding")
local function _1_()
  return vim.lsp.buf.rename()
end
vim.api.nvim_create_user_command("LspRename", _1_, {})
local function _2_()
  return vim.lsp.buf.definition()
end
vim.api.nvim_create_user_command("LspDefinition", _2_, {})
local function _3_()
  return vim.lsp.buf.code_action()
end
vim.api.nvim_create_user_command("LspAction", _3_, {})
local function _4_()
  return vim.cmd.lsp("restart")
end
vim.api.nvim_create_user_command("LspRestart", _4_, {})
local function _5_()
  return vim.lsp.buf.format()
end
vim.api.nvim_create_user_command("LspFormat", _5_, {})
local function _6_()
  return vim.lsp.buf.implementation()
end
vim.api.nvim_create_user_command("LspImplementation", _6_)
vim.diagnostic.config({virtual_text = true})
vim.lsp.enable("gopls")
vim.lsp.enable("zls")
vim.lsp.enable("pylsp")
vim.filetype.add({extension = {cshtml = "razor", maude = "maude", templ = "templ", tmpl = "gohtmltmpl", bqn = "bqn", cmp = "compila", nl = "nomenlang"}})
vim.cmd("Abolish challang{e,es,ing,ed,er} challeng{}")
vim.cmd("Abolish stirng string")
vim.cmd("Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}")
vim.cmd("Abolish ambiguoes ambiguous")
vim.cmd("Abolish ambiguos ambiguous")
local function _7_()
  return vim.cmd.Lexicon(vim.fn.expand("<cword>"))
end
vim.keymap.set("n", "<leader>l", _7_, {})
return vim.cmd("autocmd BufWritePost *.templ silent! !templ generate %")
