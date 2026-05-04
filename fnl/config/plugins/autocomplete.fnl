
(fn cmp-opts []
  (local cmp (require :cmp))
  (local luasnip (require :luasnip))
  (local m cmp.mapping)


  ;; Emmet stuff
  (fn make-set [& args]
    (collect [_ val (ipairs args)] (values val true)))

  (local emmet-filetypes
    (make-set :html :eruby :vue :templ :heex :markdown
      :htmldjango :jinja))

  (fn emmet-expandable? []
    (and (. emmet-filetypes vim.o.ft)
         (= (vim.fn.emmet#isExpandable) 1)))

  (fn emmet-expand []
    (vim.cmd "silent execute \"normal \\<Plug>(emmet-expand-abbr)\""))

  ;; Use luasnip or emmet on <tab>
  (fn on-tab [fallback]
    (if
      (luasnip.expand_or_locally_jumpable) (luasnip.expand_or_jump)
      (emmet-expandable?) (emmet-expand)
      (fallback)))

  ;; Jump back on <s-tab>
  (fn on-s-tab [fallback]
    (if
      (luasnip.locally_jumpable -1) (luasnip.jump -1)
      (fallback)))

  (local mappings
    {"<C-n>" (m.select_next_item)
     "<C-p>" (m.select_prev_item)
     "<C-d>" (m.scroll_docs -4)
     "<C-f>" (m.scroll_docs 4)
     "<C-Space>" (m.complete {})
     "<Tab>" (m on-tab [:i :s])
     "<C-k>" (m.confirm {:select true
			 :behavior cmp.ConfirmBehavior.Replace})
     "<S-Tab>" (m on-s-tab [:i :s])})

  {:mapping (m.preset.insert mappings)
   :sources [{:name :nvim_lsp}
	     {:name :buffer}
	     {:name :conjure}
	     {:name :tags}
	     {:name :luasnip}]})

(fn luasnip-config []
  (local luasnip (require :luasnip))
  (local from-lua (require :luasnip.loaders.from_lua))
  (from-lua.lazy_load {})
  (luasnip.filetype_extend :markdown [:texmath])
  (luasnip.filetype_extend :tex [:texmath])
  (luasnip.filetype_extend :templ [:go])
  (luasnip.config.setup
    {:enable_autosnippets true
     :store_selection_keys "<Tab>"
     :update_events "TextChanged,TextChangedI"}))

[:hrsh7th/cmp-buffer
 :hrsh7th/cmp-nvim-lsp
 :PaterJason/cmp-conjure
 :quangnguyen30192/cmp-nvim-tags
 :mattn/emmet-vim
 :saadparwaiz1/cmp_luasnip
 {1 :L3MON4D3/luasnip
  :config luasnip-config}
 {1 :hrsh7th/nvim-cmp
  :opts cmp-opts}]
