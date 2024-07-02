local tsquery = require("vim.treesitter.query")

tsquery.set("templ", "indents", [[
(element) @indent.begin
(tag_end) @indent.branch

(component_block) @indent.begin
(component_block
  "}" @indent.end @indent.branch .)

(conditional_attribute_block) @indent.begin

(attribute
 value: (expression) @indent.begin)

(tag_start
  ">" @indent.branch .)

(block) @indent.begin

(field_declaration_list) @indent.begin
(field_declaration_list "}" @indent.branch .)

(interface_type) @indent.begin
(interface_type "}" @indent.branch .)

(parameter_list) @indent.begin
(parameter_list ")" @indent.branch .)

(literal_value) @indent.begin
(literal_value "}" @indent.branch .)

(import_spec_list) @indent.begin
(import_spec_list ")" @indent.branch .)
]])
