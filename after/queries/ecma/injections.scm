;; extends 
(((comment) @_jsdoc_comment
  (#lua-match? @_jsdoc_comment "^/[*][*][^*].*[*]/$")) @injection.content
  (#set! injection.language "jsdoc"))

; el.innerHTML = `<html>`
(assignment_expression
  left:
    (member_expression
      property: (property_identifier) @_prop
      (#any-of? @_prop "outerHTML" "innerHTML"))
  right: (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "html"))

; el.innerHTML = '<html>'
(assignment_expression
  left:
    (member_expression
      property: (property_identifier) @_prop
      (#any-of? @_prop "outerHTML" "innerHTML"))
  right:
    (string
      (string_fragment) @injection.content)
  (#set! injection.language "html"))
