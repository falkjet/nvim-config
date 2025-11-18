-- [nfnl] init.fnl
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.lispoptions:append("expr:1")
require("config.lazy")
return vim.cmd.colorscheme("tokyonight")
