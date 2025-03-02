> [!WARNING]
> This is high in development. Don't expect anything!

# assouf

Idiomatic JavaScript Stdlib for [Melange](https://melange.re).

Melange was born out of [ReScript](https://rescript-lang.org/), and ReScript aims to be an OCaml-ish language for JavaScript developers that integrates well with JavaScript. This project instead aims to let you write OCaml applications for the browser, and make it all feel as much like OCaml as possible. Instead of using React, why not write your own in OCaml? :)

## `Es0`

`Es0` contains bindings to the core ECMAScript standard. It aims to be:

1. **Zero-cost**. It only contains type definitions and `external`s, and the generated JS files should be completely empty.
2. **Comprehensive**. It should have bindings for all the objects defined in the ECMAScript standard.
3. **Safe**, when it does not conflict with the first two rules. This means for example that `Array.get` returns an `option`.
4. **Idiomatic** for OCaml, not ReScript. Identifiers in snake_case, please.

It does not aim to:

- Implement convenience functions that do not map to the ECMAScript standard. Those can live in `Es`.
- Provide bindings to stuff that doesn't exist in the ECMAScript standard, for example `console.log` or `setTimeout`. Those can live in a different library.

## `Es`

`Es` builds on top of `Es0` to provide safe abstractions over ECMAScript APIs.
