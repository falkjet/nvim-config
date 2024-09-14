;; extends

(script_element
  (start_tag
    (attribute
      (attribute_name) @_name (#eq? @_name "lang")
      [(quoted_attribute_value (attribute_value) @injection.language)
       (attribute_value) @injection.language]))
  (raw_text)
  @injection.content)
