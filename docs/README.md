---
home: true
heroImage: '/logo.svg'
actions:
  - text: Get Started
    link: /intro
    type: primary
  - text: Design
    link: /core-modules
    type: secondary
features:
  - title: 'Report-conformant'
    details: 'Full (planned) support for R⁷RS.'
  - title: 'WebAssembly-native'
    details: 'Prioritize WebAssembly as a compilation target and FFI.'
  - title: 'WIP'
    details: '"Infantile" would be a generous characterization.'
---

WebScheme compiles [Scheme] code into [WebAssembly] modules.
This allows run-time or compile-time linkage to other WebAssembly modules,
including those implemented in foreign languages with [interface types].

WebScheme programs containing library definitions are able to produce Wasm modules.
For example, this Scheme library may result in this Wasm module,
pending the adoption of the [GC] and [type imports] proposals:

::: warning
Wasm (as well as R⁷RS) is evolving fast.
Most of the advanced features on which WebScheme intends to depend
(GC, interface types, type imports, etc.)
are in various stages of proposal,
but based on the proposals so far,
Wasm should eventually enable a compact, performant implementation.
:::

:::: code-group
::: code-group-item Scheme
@[code scheme](examples/front.scm)
:::
::: code-group-item Wasm
@[code scheme](examples/front.wat)
:::
::::

[Scheme]: /r7rs-small.pdf
[WebAssembly]: https://webassembly.org
[interface types]: https://github.com/WebAssembly/interface-types/blob/main/proposals/interface-types/Explainer.md
[GC]: https://github.com/WebAssembly/gc/tree/main/proposals/gc/Overview.md
[type imports]: https://github.com/WebAssembly/proposal-type-imports/blob/master/proposals/type-imports/Overview.md
