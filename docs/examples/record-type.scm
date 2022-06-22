;; Implicitly define the constructor, predicate, and field accessors
;; in the current scope.
(define-record-type new-type
  (new-constructor x y)
  new-predicate?
  (x get-new-x)
  (y get-new-y set-new-y))

;; Invoke the constructor to create a new instance.
(define instance (new-constructor 1 2))

;; Invoke accessors.
(display (+ (get-new-x instance) (get-new-y instance)))
