;; Library names are resolved to compiled Wasm module files by
;; converting the library name parts to their external representation
;; and concetenating them as subdirectories of the root library directory.
;; For example, `(com |Foo 😀| 12 |\x15|)`
;; would resolve to `${ROOT}/com/Foo\ 😀/12/\x15.wasm`,
;; containing either a Wasm core module also compiled by WebScheme,
;; or an adapter module compiled by anything.
(define-library (library name)

  ;; The compiler can either produce a standalone executable
  ;; or keep this import dynamic.
  (import (scheme base))

  ;; Globals and functions can be directly imported.
  (import (only (com |Foo 😀| 12 |\x15|) external-function))

  (begin
    ;; Macros are exported as simple global `syntax-rules` objects
    ;; and also listed in a special table.
    (define-syntax macro
      (syntax-rules ()
        ((macro x ...) (list x ...))))

    ;; Functions are exported as Wasm functions.
    (define (function x y)
      (+ (external-function x x) y))

    ;; All other objects are exported as globals.
    (define value "hello")

    ;; All expressions are evaluated in the module's start function.
    (display "Instantiated!"))

  (export macro function value))
