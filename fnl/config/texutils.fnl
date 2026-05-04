(fn in-mathzone []
  (= ((. vim.fn "vimtex#syntax#in_mathzone")) 1))
(fn in-text [] (not (tex-utils.in_mathzone)))
(fn in-comment []
  (= ((. vim.fn "vimtex#syntax#in_comment")) 1))
(fn in-env [name]
  (let [is-inside ((. vim.fn "vimtex#env#is_inside") name)]
    (and (> (. is-inside 1) 0) (> (. is-inside 2) 0))))
(fn in-equation [] (in-env :equation))
(fn in-itemize [] (in-env :itemize))
(fn in-tikz [] (in-env :tikzpicture))

{: in-mathzone :in_mathzone in-mathzone
 : in-text     :in_text     in-text
 : in-comment  :in_comment  in-commet
 : in-env      :in_env      in-env
 : in-equation :in_equation in_equation
 : in-itemize  :in_itemize  in-itemize
 : in-tikz     :in_tikz     in-tikz}
