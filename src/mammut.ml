open Ctypes
module T = Mammut_stubs_description.Bindings (Mammut_generated)
module Types = Mammut_stubs_description.T

let create = T.create_Mammut

let destroy = T.destroy_Mammut

let getInstanceEnergy = T.mammut_getInstanceEnergy

let ddbg = ref 0

let debug () =
  Printf.printf "debug %d\n%!" !ddbg ;
  incr ddbg

module Energy = struct
  let getCountersTypes e =
    let initial = allocate_n Types.counter_type ~count:1 in
    let arr = CArray.make ~initial (ptr Types.counter_type) 10 in
    let size = allocate int64_t 0L in
    T.energy_getCountersTypes e (CArray.start arr) size ;
    let list =
      CArray.to_list (CArray.sub ~pos:0 ~length:(Int64.to_int !@size) arr)
    in
    List.map (fun a -> !@a) list

  let getCounterByType e t =
    let res = T.energy_getCounterByType e t in
    if is_null res then raise Not_found else res

  let getCounter = T.energy_getCounter
end

module Counter = struct
  let type_to_string = function
    | Types.CPU ->
        "CPU"
    | Types.Plug ->
        "Plug"
    | Types.Unknown i ->
        "Unknown " ^ Int64.to_string i

  let getType = T.get_Type

  let reset = T.counter_reset

  let getJoules = T.counter_get_Joules
end

module CounterCpus = struct
  let getJoulesCoresAll = T.counter_get_JoulesCoresAll

  let getJoulesDramAll = T.counter_get_JoulesDramAll

  let getJoulesGraphicAll = T.counter_get_JoulesGraphicAll

  let hasDram = T.counter_hasDram

  let hasGraphic = T.counter_hasGraphic
end
