;; extends

(("function" @keyword.function)
 (#offset! @keyword.function 0 3 0 0)
 (#set! conceal "c"))

(("in" @keyword) (#set! conceal "∈"))

(("local" @keyword) (#offset! @keyword 0 0 0 -3) (#set! conceal "l"))
(("local" @keyword) (#offset! @keyword 0 2 0 -2) (#set! conceal "e"))
(("local" @keyword) (#offset! @keyword 0 3 0 0) (#set! conceal "t"))
