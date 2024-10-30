;; [nfnl-macro]

(fn on-ft [ft & args]
  (assert-compile (= :string (type ft)) "Expected a string" ft)
  (assert-compile (>= 1 (length args)) "Expected at least one expression" args)
  `(vim.api.nvim_create_autocmd
    :FileType {:pattern ,ft :callback (fn [] ,(unpack args))}))

{: on-ft}
