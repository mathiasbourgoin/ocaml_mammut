
let () =
  print_endline "#include <mammut/mammut.h>" ;
  Cstubs.write_c Format.std_formatter ~prefix:"mammut_stub_" (module Mammut_stubs_description.Bindings) 
