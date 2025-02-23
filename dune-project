(lang dune 3.8)

(name es)

(using melange 0.1)

(version 0.1)

(license "ISC")

(generate_opam_files true)

(authors "steenuil <steen@neets.work>")

(maintainers "steenuil <steen@neets.work>")

(package
 (name es0)
 (synopsis "Zero-cost Melange bindings to the ECMAScript APIs.")
 (description "Zero-cost Melange bindings to the ECMAScript APIs.")
 (depends
  (melange
   (= 5.0.0-53))
  (odoc
   (and
    (or :dev :with-doc)
    (>= 2.4.4)))))

(package
 (name es)
 (synopsis "Standard library to be used with Melange.")
 (description "Standard library to be used with Melange.")
 (depends
  (melange
   (= 5.0.0-53))
  (odoc
   (and
    (or :dev :with-doc)
    (>= 2.4.4)))
  es0))
