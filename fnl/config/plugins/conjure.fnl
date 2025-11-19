[{1 :clojure-vim/vim-jack-in
  :dependencies [:vim-dispatch]
  :cmd [:Boot :Clj :Lein]}
 {1 :Olical/conjure
  :ft [:fennel :clojure]
  :init (fn []
          (set vim.g.conjure#filetypes [:clojure :fennel]))
  :keys [["<leader>er" "<cmd>ConjureEvalRootForm<cr>"]
	 ["<leader>eb" "<cmd>ConjureEvalFile"]]}]
