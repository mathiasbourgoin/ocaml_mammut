let () =
  Cstubs.write_ml Format.std_formatter ~prefix:"mammut_stub_" (module Mammut_stubs_description.Bindings) 

