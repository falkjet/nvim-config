;; Componets
(component_block
  "}" @indent.branch @indent.end .) @indent.begin



;; Go Code
(block "}" @indent.branch @indent.end .) @indent.begin
(argument_list ")" @indent.branch @indent.end .) @indent.begin
(parameter_list ")" @indent.branch @indent.end .) @indent.begin
(field_declaration_list "}" @indent.branch @indent.end .) @indent.begin
(import_spec_list ")" @indent.branch @indent.end .) @indent.begin

;; Html
(element (tag_end) @indent.branch .) @indent.begin
(tag_start ">" @indent.branch .) @indent.begin
(self_closing_tag
  "/>" @indent.branch @indent.end) @indent.begin

;; CSS
(css_declaration
  "{" @indent.branch
  "}" @indent.branch @indent.end) @indent.begin

;; Javascript
(script_block
  "{" @indent.branch
  "}" @indent.branch @indent.end) @indent.begin

(quoted_attribute_value) @indent.align
