;; Make sure to setup `mapleader` and `maplocalleader` before
;; loading lazy.nvim so that mappings are correct.
;; This is also a good place to setup other settings (vim.opt)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")
(vim.opt.lispoptions:append "expr:1")

(require :config.lazy) ; Bootstrap lazy
(vim.cmd.colorscheme :tokyonight)


