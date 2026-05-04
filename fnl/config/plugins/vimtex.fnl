[{1 :lervag/vimtex
  :ft [:tex :markdown]
  :init (fn []
          (set vim.g.vimtex_mappings_enabled 0)
          (set vim.g.vimtex_view_method :zathura)
          (set vim.g.vimtex_quickfix_mode 1)
          (set vim.g.vimtex_syntax_conceal
            {:accents 1
             :cites 1
             :fancy 1
             :greek 1
             :ligatures 1
             :math_bounds 0
             :delimiters 1
             :math_fracs 1
             :math_super_sub 1
             :math_symbols 1
             :sections 0
             :spacing 1
             :styles 1}))}]

 []
