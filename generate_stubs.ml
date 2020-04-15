open Ctypes
open Cstubs

open Foreign

module Mt = Generate_types
module T = Mt.Types(Mammut_types)


module Bindings (F : Cstubs.FOREIGN) =  struct

  type mammut
  type energy
  type counter


  type cpuid = int Ctypes.typ
  let cpuid : cpuid = Ctypes.int

  type joules = float Ctypes.typ
  let joules : joules = Ctypes.float


  let mammut : mammut structure typ = structure "MammutHandle"
  let energy : energy structure typ = structure "MammutEnergyHandle"
  let counter : counter structure typ = structure "MammutEnergyCounter"
  let countercpus : counter structure typ = structure "MammutEnergyCounterCpus"

open F

(** class mammut *)
  let create_Mammut =
    foreign "createMammut" (void @-> returning (ptr mammut))

  let destroy_Mammut =
    foreign "destroyMammut" ((ptr mammut) @-> returning void)
  let mammut_getInstanceEnergy =
    foreign "getInstanceEnergy" (ptr mammut @-> returning (ptr energy))
  (************************* mammut.hpp **)

  let energy_getCountersTypes =
        foreign "getCountersTypes" ( ptr energy @-> ptr (ptr T.counter_type) @-> ptr int64_t @-> returning void)  

  let energy_getCounter =
    foreign "getCounter" (ptr energy @-> returning (ptr counter))

  let energy_getCounterByType =
    foreign "getCounterByType" (ptr energy @-> T.counter_type @-> returning (ptr counter))

  let get_Type =
    foreign "getType" (ptr counter @-> returning T.counter_type)
  let counter_reset =
    foreign "reset" (ptr counter @-> returning void)
  (* let counter_init =
   *   foreign "init" (ptr counter @-> returning bool) *)
  let counter_get_Joules =
    foreign "getJoules" (ptr counter @-> returning double)
  (* let counter_get_JoulesCpu  =
   *   foreign "getJoulesCpu" (ptr counter @-> cpuid @-> returning double) *)
  (* let counter_get_JoulesCpuAll =
   *   foreign "getJoulesCpuAll" (ptr counter @-> returning double) *)
  (* let counter_get_JoulesCores  =
   *   foreign "getJoulesCores" (ptr counter @-> cpuid @-> returning double) *)
  let counter_get_JoulesCoresAll =
    foreign "getJoulesCoresAll" (ptr countercpus @-> returning double)
  let counter_hasGraphic =
    foreign "hasJoulesGraphic" (ptr countercpus @-> returning bool)
  let counter_hasDram =
    foreign "hasJoulesDram" (ptr countercpus @-> returning bool)
  (* let counter_get_JoulesDram =
   *   foreign "getJoulesDram" (ptr counter @-> cpuid @-> returning double) *)
  let counter_get_JoulesDramAll =
    foreign "getJoulesDramAll" (ptr countercpus @-> returning double)
  (* let counter_get_JoulesGraphic =
   *   foreign "getJoulesGraphic" (ptr counter @-> cpuid @-> returning double) *)
  let counter_get_JoulesGraphicAll =
    foreign "getJoulesGraphicAll" (ptr countercpus @-> returning double)
(**/**)
end


let c_headers = "#include <mammut/mammut.h>"

let main () =
  let ml_out = open_out "mammut_generated.ml"
  and c_out = open_out "mammut_stubs.c" in
  let ml_fmt = Format.formatter_of_out_channel ml_out
  and c_fmt = Format.formatter_of_out_channel c_out in
  Format.fprintf c_fmt "%s@\n" c_headers;
  Cstubs.write_c c_fmt ~prefix:"mammut_stub_" (module Bindings);
  Cstubs.write_ml ml_fmt ~prefix:"mammut_stub_" (module Bindings);
  Format.pp_print_flush ml_fmt ();
  Format.pp_print_flush c_fmt ();
  close_out ml_out;
  close_out c_out
                                          
  
let _ = main ()
