;; Note that the supertype just has a unique type ID:
(type $s-record (struct i32))

;; The generated consrtuctor is always a single `struct.new` instruction.
(func $new-constructor (export "new-constructor")
                       (param $x $s-object) (param $y $s-object)
                       (result $s-object)
  ;; Use `42` as the unique type ID for `new-type`.
  (struct.new (i32.const 42) (local.get $x) (local.get $y)))

;; The generated predicate makes use of runtime types (TODO).
(func $new-predicate (export "new-predicate?")
                     (param $obj $s-object)
                     (result $s-bool)
  (struct.get 1 (local.get $obj)))

;; The generated getters are always single `struct.get` instructions.
(func $get-new-x (export "get-new-x")
                 (param $obj $s-object)
                 (result $s-object)
  (struct.get 1 (local.get $obj)))

(func $get-new-y (export "get-new-y")
                 (param $obj $s-object)
                 (result $s-object)
  (struct.get 2 (local.get $obj)))

;; The generated setters are always single `struct.set` instructions.
(func $set-new-y (export "set-new-y")
                 (param $obj $s-object) (param $value $s-object)
                 (result $s-object)
  (struct.set 2 (local.get $obj) (local.get $value)))
