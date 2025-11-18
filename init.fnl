;; Make sure to setup `mapleader` and `maplocalleader` before
;; loading lazy.nvim so that mappings are correct.
;; This is also a good place to setup other settings (vim.opt)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")

(require :config.lazy) ; Bootstrap lazy
(let [lazy (require :lazy)]
  (lazy.setup
    {:spec [["Olical/nfnl"]]
     :install {:colorscheme [:habamax]}}))
