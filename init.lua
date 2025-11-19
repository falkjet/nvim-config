-- [nfnl] init.fnl
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.wo.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.opt.lispoptions:append("expr:1")
require("config.lazy")
vim.cmd.colorscheme("tokyonight")
return vim.keymap.set("i", "jj", "<esc>")
