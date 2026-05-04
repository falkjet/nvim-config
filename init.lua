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
vim.opt.lispoptions:append("expr:1")
require("config.lazy")
vim.cmd.colorscheme("tokyonight")
vim.keymap.set("i", "jj", "<esc>")
require("config.folding")
local function _1_()
  return vim.lsp.buf.rename()
end
vim.api.nvim_create_user_command("LspRename", _1_, {})
vim.lsp.enable("gopls")
vim.lsp.enable("zls")
return vim.filetype.add({extension = {cshtml = "razor", maude = "maude", templ = "templ", tmpl = "gohtmltmpl", bqn = "bqn", cmp = "compila", nl = "nomenlang"}})
