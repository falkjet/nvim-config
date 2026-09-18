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
(set vim.o.smartcase true)
(set vim.o.ignorecase true)
(vim.opt.lispoptions:append "expr:1")

(require :config.lazy) ; Bootstrap lazy
(vim.cmd.colorscheme :tokyonight)

(require :config.folding)


(vim.api.nvim_create_user_command :LspRename (fn [] (vim.lsp.buf.rename)) {})
(vim.api.nvim_create_user_command :LspDefinition (fn [] (vim.lsp.buf.definition)) {})
(vim.api.nvim_create_user_command :LspAction (fn [] (vim.lsp.buf.code_action)) {})
(vim.api.nvim_create_user_command :LspRestart (fn [] (vim.cmd.lsp "restart")) {})
(vim.api.nvim_create_user_command :LspFormat (fn [] (vim.lsp.buf.format)) {})
(vim.api.nvim_create_user_command :LspImplementation (fn [] (vim.lsp.buf.implementation)))

(vim.diagnostic.config {:virtual_text true})

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
