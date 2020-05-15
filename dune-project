(lang dune 2.5)
(name mammut)
(version 0.0.1)

(generate_opam_files true)

(source (github mathiasbourgoin/ocaml_mammut))
(license CECILL-B)
(authors "Mathias Bourgoin")
(maintainers "mathias.bourgoin@gmail.com")

(package
 (name mammut)
 (synopsis "An OCaml binding to the Mammut library")
 (description "OCaml bindings to the mammut energy that offers an easy access to architectural features normally expose\
d by means of sysfs files or CPU registries such as energy profiling or fine core and frequency manipulation")
  (depends 
  ("dune" (> 2.5))
  "conf-cmake"
  "ctypes"
))

