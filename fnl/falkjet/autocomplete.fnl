;; Autocomplete
(local cmp (require :cmp))
(local luasnip (require :luasnip))
(local m cmp.mapping)

;; Emmet stuff
(fn make-set [& args] (collect [_ val (ipairs args)] (values val true)))
(local emmet-filetypes (make-set :html :eruby :vue :templ))
(fn emmet-expandable? [] (and (. emmet-filetypes vim.o.ft) (= (vim.fn.emmet#isExpandable) 1)))
(fn emmet-expand [] (vim.cmd "silent execute \"normal \\<Plug>(emmet-expand-abbr)\""))

;; Use luasnip or emmet on <tab>
(fn on-tab [fallback]
    (if
      (luasnip.expand_or_locally_jumpable) (luasnip.expand_or_jump)
      (emmet-expandable?) (emmet-expand)
      (fallback)))

;; Jump back on <s-tab>
(fn on-s-tab [fallback]
    (if (luasnip.locally_jumpable -1) (luasnip.jump -1) (fallback)))

;; Configure cmp
(cmp.setup
  {:snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
  :mapping (m.preset.insert
             {"<C-n>" (m.select_next_item)
             "<C-p>" (m.select_prev_item)
             "<C-d>" (m.scroll_docs -4)
             "<C-f>" (m.scroll_docs 4)
             "<C-Space>" (m.complete {})
             "<Tab>" (m on-tab [:i :s])
             "<c-k>" (m.confirm {:select true
                                :behavior cmp.ConfirmBehavior.Replace})
             "<S-Tab>" (m on-s-tab [:i :s])})
  :sources [{:name :conjure}
                   {:name :buffer}
                   {:name :nvim_lsp}
                   {:name :tags}]})

