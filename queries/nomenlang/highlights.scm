(identifier) @variable
(number) @number
(comment) @comment
(string) @string

(parameter name: (identifier) @variable.parameter)
(parameter type: (identifier) @type)


(function_definition (identifier) @function)
(call (identifier) @function)

(record_definition
  name: (identifier) @type.record)
(record_field name: (identifier) @variable.member)
(record_field type: (identifier) @type)


[
  "fn"
  "for"
  "if"
  "in"
  "let"
  "return"
  "record"
  "init"
  "global"
  (break_statement)
  (continue_statement)
] @keyword


[
  ":"
  ","
  ";"
  "="
] @punctuation.delimiter

[
  "("
  ")"
  "{"
  "}"
] @punctuation.bracket

;; vim: sw=0 ts=2 et
