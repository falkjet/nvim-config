
(fn in-lisp []
  (or vim.o.lisp
      (= :fennel vim.o.ft)
      (= :clojure vim.o.ft)))

(fn single-quote-cond [fun]
  (or (not (in-lisp))
   (fun.in_string)))

(fn backtick-cond [fun]
  (or (not (in-lisp))
    (fun.in_string)))

[{1 :altermo/ultimate-autopair.nvim
  :event [:InsertEnter :CmdlineEnter]
  :branch :v0.6
  :opts {:internal_pairs [{1 "[" 2 "]" :dosuround true :fly true :newline true :space true :cond (fn [fun] (not (in-lisp)))}
			  {1 "(" 2 ")" :dosuround true :fly true :newline true :space true :cond (fn [fun] (not (in-lisp)))}
			  {1 "{" 2 "}" :dosuround true :fly true :newline true :space true :cond (fn [fun] (not (in-lisp)))}
			  {1 "[" 2 "]" :dosuround true :fly true :newline false :space true :cond (fn [fun] (in-lisp))}
			  {1 "(" 2 ")" :dosuround true :fly true :newline false :space true :cond (fn [fun] (in-lisp))}
			  {1 "{" 2 "}" :dosuround true :fly true :newline false :space true :cond (fn [fun] (in-lisp))}

			  {1 "\"" 2 "\"" :multiline false :suround true}
			  {1 "'" 2 "'" :alpha true :cond single-quote-cond :multiline false :nft [:tex] :suround true}
			  {1 "`" 2 "'" :ft [:m4]}
			  {1 "`" 2 "`" :cond backtick-cond :multiline false :nft [:tex :m4]}
			  {1 "``" 2 "''" :ft [:tex]}
			  {1 "```" 2 "```" :ft [:markdown] :newline true}
			  {1 "<!--" 2 "-->" :ft [:markdown :html] :space true}
			  {1 "\"\"\"" 2 "\"\"\"" :ft [:python] :newline true}
			  {1 "'''" 2 "'''" :ft [:python] :newline true}]}}]

[{1 :windwp/nvim-autopairs
  :event :InsertEnter
  :config true
  :init
  (fn []
    (tset (. ((. (require :nvim-autopairs) :get_rules) "'") 1) :not_filetypes
      [:scheme :lisp]))}]
