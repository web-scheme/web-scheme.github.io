;; The compiled core module.
;; Using extensions, it would also be possible to produce an adapter module.
(module

  ;; The special "s-lang" module is the runtime.
  ;; Types and functions are imported as needed and always statically linked.
  ;; Two S-lang programs compiled against different versions of the runtime
  ;; may have incompatible ABIs.
  (import "s-lang" "t-obj" (type $t-obj))                    ;; Super-type for all objects.
  (import "s-lang" "t-pair" (type $t-pair))                  ;; Pair type.
  (import "s-lang" "t-string" (type $t-string))              ;; String type.
  (import "s-lang" "t-syntax-rules" (type $t-syntax-rules))  ;; `syntax-rules` (macro) type.
  (import "s-lang" "t-null" (type $t-null))                  ;; Null type.
  (import "s-lang" "null" (global $null))                    ;; Null value.

  ;; The import compiler can statically analyze libraries
  ;; to only import what it needs for import sets without an `only` clause.
  ;; `display` only takes 1 parameter: the list of parameters.
  ;; This is true of all functions defined as `(<name> . <parameters>)`,
  ;; and allows a rare (if limited) opportunity for static typing.
  (import "(scheme base)" "display" (func $display (param $t-pair)))

  ;; The module name is the canonical external representation
  ;; of the entire library name.
  ;; The function signature is determined by inspection of the dependency
  ;; at compile-time.
  (import "(com |Foo 😀| 12 |\x15|)" "external-function" (func (param $t-obj) (result $t-obj)))

  ;; `syntax-rules` (a.k.a macros) can be imported and exported,
  ;; and have a run-time representation.
  ;; Although dynamic imports will not affect already-running code
  ;; (and at that point could only really be used with `eval`),
  ;; static (as configurable by compiler flag) imports apply to subsequent code.
  (global $macro (export "macro") $t-syntax-rules ...)

  (func $function (export "function") (param $x $t-obj) (param $y $t-obj) ...)

  (global $value (export "value") $t-string ...)

  (func $_start ...)

  (start $_start))
