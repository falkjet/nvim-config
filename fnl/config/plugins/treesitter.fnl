[{1 :nvim-treesitter/nvim-treesitter
  :branch :main
  :lazy false
  :build ":TSUpdate"
  :main :nvim-treesitter
  :init (fn []
          (vim.api.nvim_create_autocmd
            :User
            {:pattern :TSUpdate
             :callback (fn []
                         (tset (require :nvim-treesitter.parsers) :compila
                           {:install_info
                            {:url "https://github.com/falkjet/tree-sitter-compila"
                             :queries :queries}}))})

          (vim.api.nvim_create_autocmd :FileType
            {:callback (fn []
                         (pcall vim.treesitter.start)
                         (when (not= :fennel vim.o.ft)
                           (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()")))}))
  :opts {:indent {:enable true
                  :disable [:scheme :lisp :clojure :fennel]}
         :highlight {:enable true}
         :indent {:enable true}
         :incremental_selection {:enable true
                                 :keymaps {:init_selection "<M-o>"
                                           :node_incremental "<M-o>"}}}}]
