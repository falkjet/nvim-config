;; extends
(call_expression
  function:
  (selector_expression
    field: (field_identifier)@_field
    (#match? @_field "^(Queryx?|(Must)?Exec(ute)?)$"))
  arguments:
  (argument_list
    (raw_string_literal)
    @injection.content
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.language "sql")))
