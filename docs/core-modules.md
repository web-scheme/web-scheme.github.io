# Core Modules

All compiled WebScheme programs are Wasm modules.
They can either be executable (i.e. no exports, usually a start function),
or they represent a [library definition]:

- `import` and `export` declarations translate to Wasm imports and exports,
  respectively.
- Any definitions from `begin`, `include`, or `include-ci`
  declarations translate to global variables or functions.
- Any non-definition expressions from `begin`, `include`, or `include-ci`
  declarations are evaluated in-order in the start function.
- `include-library-declarations` may similarly add to the start function,
  and it may also add to the imports / exports.

[library definition]: /r7rs-small.pdf#subsection.5.6.1

## Type ABI

::: warning
WebScheme will depend on the final implementation of the [GC proposal],
so this design is subject to change.
:::

| Scheme type predicate | Wasm type                                           |
| --------------------: | :-------------------------------------------------- |
|            `boolean?` | `(type (mut i32))`                                  |
|         `bytevector?` | `(type (array (mut i8)))`                           |
|               `char?` | `(type (mut i32))`                                  |
|         `eof-object?` | unary?\*                                            |
|               `null?` | unary?\*                                            |
|             `number?` | `(variant (case "exact" i64) (case "inexact" f64))` |
|               `pair?` | `(type (struct (mut anyref) (mut anyref)))`         |
|               `port?` | TODO                                                |
|          `procedure?` | `(type funcref)`                                    |
|             `string?` | `(type (mut string))`                               |
|             `symbol?` | `(type string)`                                     |
|             `vector?` | `(type (array (mut anyref)))`                       |

\* _Would it be possible to represent unary types
with Wasm's proposed ["variant" types]_?

The union of all these types,
as well as the common record supertype defined below,
is referred to `$t-obj`
and is generally the type of all globals and function parameters and return values
(with some exceptions).

[GC proposal]: https://github.com/WebAssembly/gc/blob/main/proposals/gc/Overview.md
["variant" types]: https://github.com/WebAssembly/gc/blob/main/proposals/gc/Post-MVP.md#variants

### Record Types

Ideally, types defined using [`define-record-type`]
would be implemented using *extensible union types*
as mentioned in the post-MVP section of the [GC proposal].

[`define-record-type`]: /r7rs-small.pdf#section.5.5
[GC proposal]: https://github.com/WebAssembly/gc/blob/af0acce7f1bb4432c27e3a06753249ad13895639/proposals/gc/Post-MVP.md#variants
