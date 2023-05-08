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
# TODO: See if we can replace svg.external-link-icon with `<ExternalLinkIcon />`
#       https://v2.vuepress.vuejs.org/reference/plugin/external-link-icon.html#components
footer: <a href="https://matrix.to/#/#web-scheme:matrix.org" target="_blank"><svg version="1.1" viewBox="0 0 27.9 32" style="height:1em;position:relative;top:.125em" xmlns="http://www.w3.org/2000/svg" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"><g transform="translate(-.095 .005)" fill="var(--c-text)"><path d="m27.1 31.2v-30.5h-2.19v-0.732h3.04v32h-3.04v-0.732z"/><path d="m8.23 10.4v1.54h0.044c0.385-0.564 0.893-1.03 1.49-1.37 0.58-0.323 1.25-0.485 1.99-0.485 0.72 0 1.38 0.14 1.97 0.42 0.595 0.279 1.05 0.771 1.36 1.48 0.338-0.5 0.796-0.941 1.38-1.32 0.58-0.383 1.27-0.574 2.06-0.574 0.602 0 1.16 0.074 1.67 0.22 0.514 0.148 0.954 0.383 1.32 0.707 0.366 0.323 0.653 0.746 0.859 1.27 0.205 0.522 0.308 1.15 0.308 1.89v7.63h-3.13v-6.46c0-0.383-0.015-0.743-0.044-1.08-0.0209-0.307-0.103-0.607-0.242-0.882-0.133-0.251-0.336-0.458-0.584-0.596-0.257-0.146-0.606-0.22-1.05-0.22-0.44 0-0.796 0.085-1.07 0.253-0.272 0.17-0.485 0.39-0.639 0.662-0.159 0.287-0.264 0.602-0.308 0.927-0.052 0.347-0.078 0.697-0.078 1.05v6.35h-3.13v-6.4c0-0.338-7e-3 -0.673-0.021-1-0.0114-0.314-0.0749-0.623-0.188-0.916-0.108-0.277-0.3-0.512-0.55-0.673-0.258-0.168-0.636-0.253-1.14-0.253-0.198 0.0083-0.394 0.042-0.584 0.1-0.258 0.0745-0.498 0.202-0.705 0.374-0.228 0.184-0.422 0.449-0.584 0.794-0.161 0.346-0.242 0.798-0.242 1.36v6.62h-3.13v-11.4z"/><path d="m0.936 0.732v30.5h2.19v0.732h-3.04v-32h3.03v0.732z"/></g></svg> Chat <span><svg class="external-link-icon" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path><polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg><span class="external-link-icon-sr-only">open in new window</span></span></a> about this.
footerHtml: true
---

WebScheme compiles [Scheme] code into [WebAssembly] modules.
This allows run-time or compile-time linkage to other WebAssembly modules,
including those implemented in foreign languages via [components].

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
[components]: https://github.com/WebAssembly/component-model
[GC]: https://github.com/WebAssembly/gc
[type imports]: https://github.com/WebAssembly/proposal-type-imports
