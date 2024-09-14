;; extends

(macro_invocation
  macro:
  (scoped_identifier)
  @_ident
  (#match? @_ident "sqlx::query(_as)?")
  (token_tree
    (raw_string_literal
      (string_content) @injection.content
      (#set! injection.language "sql"))))

