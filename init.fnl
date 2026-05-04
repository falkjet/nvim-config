;; Make sure to setup `mapleader` and `maplocalleader` before
;; loading lazy.nvim so that mappings are correct.
;; This is also a good place to setup other settings (vim.opt)
(set vim.g.mapleader " ")
(set vim.g.maplocalleader "\\")
(set vim.wo.relativenumber true)
(set vim.wo.number true)
(set vim.o.clipboard :unnamedplus)
(set vim.o.undofile true)
(set vim.o.shiftwidth 0)
(set vim.o.tabstop 4)
(set vim.o.exrc true)
(vim.opt.lispoptions:append "expr:1")

(require :config.lazy) ; Bootstrap lazy
(vim.cmd.colorscheme :tokyonight)

(vim.keymap.set :i "jj" "<esc>")

(require :config.folding)


(vim.api.nvim_create_user_command :LspRename (fn [] (vim.lsp.buf.rename)) {})

(vim.lsp.enable :gopls)
(vim.lsp.enable :zls)

(vim.filetype.add
  {:extension
   {:cshtml :razor
    :maude  :maude
    :templ  :templ
    :tmpl   :gohtmltmpl
    :bqn    :bqn
    :cmp    :compila
    :nl     :nomenlang}})
