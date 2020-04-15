open Ctypes
open Cstubs


module Types(T:Cstubs.Types.TYPE) = struct
  type counter_type = CPU | Plug | Unknown of int64

  let cpu = T.constant "COUNTER_CPUS" T.int64_t
  let plug = T.constant "COUNTER_PLUG" T.int64_t
  let counter_type = T.enum ~typedef:true
                       ~unexpected:(fun x -> Unknown x)
                       "MammutEnergyCounterType" [CPU, cpu; Plug, plug]

end

let () = (* generate the c-side type bindings : *)
  let f = Format.formatter_of_out_channel @@ open_out "mammut_types.c" in
  Format.fprintf f {|#include <mammut/mammut.h>@.|};
  Cstubs.Types.write_c f (module Types)

