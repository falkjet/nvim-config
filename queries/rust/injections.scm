;; (macro_invocation
;;   (scoped_identifier
;;     path: (identifier) @_path (#eq? @_path "sqlx")
;;     name: (identifier) @_name (#eq? @_path "query"))
;;   (token_tree
;;     (raw_string_literal) @sql
;;     (#offset! sql 1 0 0 0)))

(macro_invocation
  macro: (scoped_identifier
           path: (identifier) @_path (#eq? @_path "sqlx")
           name: (identifier) @_name (#eq? @_name "query"))
  (token_tree
    (raw_string_literal) @sql
    (#offset! @sql 0 3 0 0)))
