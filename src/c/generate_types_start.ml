
let () =
  (* generate the c-side type bindings : *)
  print_endline "#include <mammut/mammut.h>" ;
  Cstubs.Types.write_c Format.std_formatter (module Generate_types.Types)
