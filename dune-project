(lang dune 3.8)

(name melange_es)

(version 0.1)

(license "ISC")

(generate_opam_files true)

(authors "steenuil <steen@neets.work>")

(maintainers "steenuil <steen@neets.work>")

(package
 (name es0)
 (synopsis "Zero-cost OCaml bindings to the ECMAScript APIs.")
 (description "Zero-cost OCaml bindings to the ECMAScript APIs.")
 (depends
  (melange
   (= 5.0.0-53))
  (odoc
   (>= 2.4.4))))
