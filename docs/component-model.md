# Component Model

The Scheme Steering Committee once called Scheme
*the world's most unportable programming language* [¹].
This implementation tries to deviate from the report as little as possible,
however Wasm's [component model] presents a conundrum:
Scheme is an untyped language,
so taking advantage of Wasm component-level value types —
and thus allowing WebScheme to interoperate with the rest of the Wasm ecosystem —
will require extensions to the way Scheme libraries are defined.
In this case only, the benefit is seen to far outweigh the consequences of deviation.

[¹]: http://scheme-reports.org/2009/position-statement.html
[component model]: https://github.com/WebAssembly/component-model

## Interface Type Annotations

Other schemes have tried to extend the language with types,
such as [typed Racket].
In most cases,
extensions rely on complex non-standard syntax for concision and flexibility,
making code highly unportable.
WebScheme makes use of typed Racket's special `:` pseudo-function,
however it:

- eschews the syntactic sugar for inline annotations,
- requires definitions to precede annotations, and
- uses Wasm types instead of Scheme types.

This achieves the goal of Wasm interoperability
while allowing WebScheme programs to be ported easily,
by defining `:` as a no-op macro:
`(define-syntax : (syntax-rules () ((: name type ...) (set! name name))))`.

Rough idea:

```scheme
;; A simple example for a global variable.
;; Assigning to any annotated object incurs an implicit type check.
;; If type safety can be fully checked statically, no runtime overhead.
(define x 5)
(: x s32)

;; Wasm's convenient choice to use S-expressions for the text representation
;; means we can use its type notations verbatim! :D
(define (foo x y)
  (+ x y))
(: foo (func (param float64 s32) (result float64)))

;; If a function is indeed meant to accept any Scheme object,
;; the special built-in `_` type abbreviation can be used for convenience.
;; Note that this actually does map to a coherent Wasm union type.
(define (bar head . tail)
  (if (string? head)
    head
    (if (null? tail)
      #f
      (bar tail))))
(: bar (func (param _ (list _)) (result (union string bool))))

;; Annotating a record type introduces a new type abbreviation
;; that can be used in other annotations (in the same scope),
;; even recursively.
(define-record-type pare
  (kons a b)
  pare?
  (a kar set-kar!)
  (b kdr set-kdr!))
(: pare (record (field "a" string) (field "b" (union pare unit))))
```

[typed Racket]: https://docs.racket-lang.org/ts-guide/
