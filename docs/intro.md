# Get Started

## In-Browser

Wishful thinking.
This project is years away.
But one can dream:
a self-hosting, Wasm-targetting (thus Wasm-implemented) compiler
could be distributed entirely via CDN and run in-browser,
producing programs that run in-browser.
Or the entire compiler could run "serverless",
serving sandboxed, performant binaries for Scheme-coded requests,
or just compile everything to native,
etc.

In Wasm world, app stores are CDNs,
from which software can be "installed" primarily into web caches,
everything sandboxed and performant,
and sophisticated FFI means a single ecosystem for universal libraries.
Scheme's knack for symbolic manipulation
and fluid line between data and code
fit into this world better than most would have hoped.

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

### Spaghetti?

Lisp means "**Lis**t **P**rocessor".
This is deceiving.

[The pair] may be the simplest form of linked list,
consisting of just a value (the `car`) and a 'next'-pointer (the `cdr`),
but it's generally better to think of it as a node in a [spaghetti stack] —
something you can push and pop like a stack,
but that can also split like a tree.
This data structure gently nudges you
to implement things recursively or concurrently,
and rewards you for complying.

:::: code-group
::: code-group-item Scheme
@[code scheme](examples/spaghetti.scm)
:::
::: code-group-item Sweet
@[code scheme](examples/spaghetti.sscm)
:::
::::

This may seem contrived,
but the syntax also encourages good practice
by compelling you to break down functions and expressions
into their essential pieces, and compose them together.
TODO: Elaborate.

[The pair]: /r7rs-small.pdf#section.6.4
[spaghetti stack]: https://en.wikipedia.org/wiki/Parent_pointer_tree

### Other Trees

The spaghetti stack interpretation
is one way of making trees out of Lisp's lists,
and using them to guide natural implementations
of recursive and concurrent algorithms.
There's a different way to interpret lists as trees:
[syntax trees].
Rather than being useful for algorithmic implementation,
this interpretation is useful for metaprogramming.

Parsing the syntax tree from the source code
is the first job of any compiler,
because it's easier to analyze and transform code in that form.
Consider how you might visualize the AST for this function:

:::: code-group
::: code-group-item Scheme
```scheme
(define (f x)
  (if (< x 5)
    (begin
      (display "Under!")
      (+ x 5))
    (- x 5)))
```
:::
::: code-group-item AST
![Alt text](https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.publicdomainpictures.net%2Fpictures%2F40000%2Fvelka%2Ffluffy-clouds.jpg&f=1&nofb=1 "fersher")
:::
::::

Notice how there's a simple 1-to-1 correspondence
between the AST structure and the source code itself:
each AST leaf is an atom like the number `5` or the symbol `<`,
and each AST subtree is a list where the head is the parent
and the tail is the list of children (each of which could also be a subtree).
Whereas the spaghetti stack tree had children pointing to their parent,
this tree has parents pointing to their (list of) children.
Lisp source code is *already* a syntax tree when you write it!

Not only does this make parsing somewhat simpler for Lisp compilers,
it means that Lisp source code is naturally in a form that is
relatively easy to analyze and transform programmatically.
This opens the door to metaprogramming
in the form of both Lisp's famous macro system
as well as it's even more powerful [evaluation mechanism].
This is Lisp's iconic [homoiconicity],
the property that data and code share a representation,
but that representation is better thought of as a tree than a list.

*List Processor* oversimplifies.

[syntax trees]: https://en.wikipedia.org/wiki/Abstract_syntax_tree
[evaluation mechanism]: /r7rs-small.pdf#section.6.12
[homoiconicity]: https://en.wikipedia.org/wiki/Homoiconicity
