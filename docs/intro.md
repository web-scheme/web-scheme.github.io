# Get Started

## In-Browser

Wishful thinking.
This project is years away.
But one can dream:
a self-hosting, Wasm-targetting (thus Wasm-implemented) compiler
could be distributed entirely via CDN and run in-browser,
producing programs that run in-browser.
Or the entire compiler could run "serverless",
serving binary responses to Scheme-coded requests,
Or, everything could just be compiled to native, etc.

In Wasm world, app stores are just CDNs,
from which software can be "installed" primarily into web caches,
everything sandboxed and performant,
and sophisticated FFI means a single ecosystem for universal libraries.
Scheme's knack for symbolic manipulation
and fluid line between data and code
fit into this world better than many would have hoped.

## Intro to Lisp

If you don't know anything about Lisp,
there's still nothing better than the [wizard book],
which takes a light-hearted approach,
starts at square one,
and is designed to blow your mind.
Those who prefer dry brevity should read the entire [language report].
Yes, this is Scheme, not Common Lisp.
The rest of this "intro" assumes you already know
the basics of Lisp.

[wizard book]: https://mitpress.mit.edu/sites/default/files/sicp/index.html
[language report]: /r7rs-small.pdf

### It's not about lists

Lisp means "**Lis**t **P**rocessor".
This is deceiving.

[The pair] may be the simplest form of linked list,
consisting of just a value (the `car`) and a 'next'-pointer (the `cdr`),
but I find it better to think of it as a node in a [spaghetti stack] —
something you can push and pop like a stack,
but that splits like a tree.
This data structure gently nudges you
to implement things recursively / concurrently.

:::: code-group
::: code-group-item Scheme
@[code scheme](examples/spaghetti.scm)
:::
::: code-group-item Sweet
@[code scheme](examples/spaghetti.sscm)
:::
::::

It may seem contrived,
but the syntax encourages good practice
by compelling you to break down functions and expressions
into their essential pieces, and compose them together.
TODO: Elaborate.

[The pair]: /r7rs-small.pdf#section.6.4
[spaghetti stack]: https://en.wikipedia.org/wiki/Parent_pointer_tree

### More than one type of tree

The spaghetti stack interpretation
is one way of making trees out of Lisp's lists,
and using them to guide natural implementations
of recursive and concurrent algorithms.
But, there's another way to interpret these lists as trees:
*syntax trees*.
We'll use this interpretation to make a hand-wavy argument
about why lisp macros are so cool.

Parsing the [abstract syntax tree] (AST) from source code
is the first job of any compiler.
This is the form in which
it's considered convenient to transform and inspect code.
Consider how you might visualize an AST for this function:

:::: code-group
::: code-group-item Scheme
```scheme
;;* A basic example of a function definition.

;; Syntactically, `(f x y)` here is a function call. However,
;; when a function "call" appears as the L-value in a definition syntax like this,
;; it means the function is being defined rather than invoked.
;; It's actually just shorthand for `(define f (lambda (x y) ...))`.
(define (f x y)
  (if (< x y)
    (begin
      (display "Under!")
      (- y x))
    (+ x 5)))
```
:::
::: code-group-item AST
<div style="background-color:var(--code-bg-color)">
<img src="/ast-example.svg" title="An example syntax tree" style="display:block;margin-left:auto;margin-right:auto;height:383px;">
</div>
:::
::::

Notice how there's a simple mapping
between the AST structure and the source code itself:

- Each AST leaf maps to an atom, like the variable `x` or the string `"Under!"`.
- Each subtree has either a function call or *syntax* (like `define`, `if`, or `begin`)
  at the root.

The distinction between function and syntax is unimportant here
because both are written as [*s-expressions*].
The `car` is the parent node,
and the `cdr` is the list of children (each of which could also be a subtree).
Whereas the spaghetti stack tree interpretation had children pointing to their parent,
this interpretation has parents pointing to their (list of) children.
Lisp source code is essentially *already* in syntax tree form when you write it!

Not only does this make parsing somewhat simpler for Lisp compilers,
it means that Lisp source code is naturally in a form that is
relatively easy to transform and analyze programmatically.
This is what opens the door to metaprogramming
in the form of both the macro system
as well as the even more powerful [evaluation mechanism].
This is Lisp's iconic [homoiconicity],
the property that data and code share a representation,
but often that representation is better thought of in terms of trees than lists.

*List Processor* oversimplifies.

[abstract syntax tree]: https://en.wikipedia.org/wiki/Abstract_syntax_tree
[*s-expressions*]: https://en.wikipedia.org/wiki/S-expression
[evaluation mechanism]: /r7rs-small.pdf#section.6.12
[homoiconicity]: https://en.wikipedia.org/wiki/Homoiconicity
