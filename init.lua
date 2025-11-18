-- [nfnl] init.fnl
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.lispoptions:append("expr:1")
require("config.lazy")
vim.cmd.colorscheme("tokyonight")
return vim.keymap.set("i", "jj", "<esc>")
