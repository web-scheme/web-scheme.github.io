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
footer: <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" style="height:1em;position:relative;top:.125em;margin-right:.5em"><path fill="var(--c-text)" d="M0 128C0 92.65 28.65 64 64 64H448C483.3 64 512 92.65 512 128V384C512 419.3 483.3 448 448 448H64C28.65 448 0 419.3 0 384V128zM48 128V150.1L220.5 291.7C241.1 308.7 270.9 308.7 291.5 291.7L464 150.1V127.1C464 119.2 456.8 111.1 448 111.1H64C55.16 111.1 48 119.2 48 127.1L48 128zM48 212.2V384C48 392.8 55.16 400 64 400H448C456.8 400 464 392.8 464 384V212.2L322 328.8C283.6 360.3 228.4 360.3 189.1 328.8L48 212.2z"/></svg>Join the <a href="https://groups.google.com/a/web-scheme.org/g/dev" target="_blank">developer mailing list</a> to get involved!
footerHtml: true
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
