;; Autocomplete
(let [cmp (require :cmp)
          luasnip (require :luasnip)]
  (local m cmp.mapping)
  (fn on-tab [fallback]
    ((if (luasnip.expand_or_locally_jumpable) luasnip.expand_or_jump fallback)))
  (fn on-s-tab [fallback]
    (if (luasnip.locally_jumpable -1) (luasnip.jump -1) (fallback)))
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
               {:name :tags}]}))

