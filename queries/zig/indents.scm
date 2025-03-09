
(struct_declaration
  "{" @indent.branch
  "}" @indent.branch @indent.end .
  ) @indent.begin

(initializer_list
  "{" @indent.branch
  "}" @indent.branch @indent.end .
  ) @indent.begin

(parameters
  "(" @indent.branch
  ")" @indent.branch @indent.end .
  ) @indent.begin

(call_expression
  "(" @indent.branch
  ")" @indent.branch @indent.end .
  ) @indent.begin

(block
  "{" @indent.branch
  "}" @indent.branch @indent.end .
  ) @indent.begin
