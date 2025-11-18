-- [nfnl] init.fnl
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("config.lazy")
local lazy = require("lazy")
return lazy.setup({spec = {{"Olical/nfnl"}}, install = {colorscheme = {"habamax"}}})
