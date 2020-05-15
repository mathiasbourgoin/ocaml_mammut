open Ctypes
module T = Mammut_stubs_description.Bindings (Mammut_generated)
module Types = Mammut_stubs_description.T

type t = T.mammut Ctypes.structure Ctypes_static.ptr

let create = T.create_Mammut

let destroy = T.destroy_Mammut

let default = T.create_Mammut ()

module Topology = struct
  module Cpu = struct
    type t = T.Topology.Cpu.t Ctypes.structure Ctypes_static.ptr

    let getFamily = T.Topology.Cpu.getFamily

    let getModel = T.Topology.Cpu.getModel

    let getCpuId = T.Topology.Cpu.getCpuId
  end

  type t = T.Topology.t Ctypes.structure Ctypes_static.ptr

  let default : t = T.mammut_getInstanceTopology default

  let getCpus ?topology:(t = default) () : Cpu.t list =
    let arr = CArray.make (ptr (ptr T.Topology.Cpu.t)) 10 in
    let size = allocate int64_t 0L in
    T.Topology.getCpus t (CArray.start arr) size ;
    let list =
      CArray.to_list (CArray.sub ~pos:0 ~length:(Int64.to_int !@size) arr)
    in
    List.map (fun a -> !@a) list
end

module Energy = struct
  module Counter = struct
    type counter_type = Types.counter_type = CPU | Plug | Unknown of int64

    let type_to_string = function
      | Types.CPU -> "CPU"
      | Types.Plug -> "Plug"
      | Types.Unknown i -> "Unknown " ^ Int64.to_string i

    type t = T.Energy.Counter.t Ctypes.structure Ctypes_static.ptr

    let getType = T.Energy.Counter.get_Type

    let reset = T.Energy.Counter.reset

    let getJoules = T.Energy.Counter.get_Joules

    module Cpu = struct
      let getJoulesCpuAll = T.Energy.Counter.Cpu.get_JoulesCpuAll

      let getJoulesCpu = T.Energy.Counter.Cpu.get_JoulesCpu

      let getJoulesCoresAll = T.Energy.Counter.Cpu.get_JoulesCoresAll

      let getJoulesCores = T.Energy.Counter.Cpu.get_JoulesCores

      let getJoulesDramAll = T.Energy.Counter.Cpu.get_JoulesDramAll

      let getJoulesDram = T.Energy.Counter.Cpu.get_JoulesDram

      let getJoulesGraphicAll = T.Energy.Counter.Cpu.get_JoulesGraphicAll

      let getJoulesGraphic = T.Energy.Counter.Cpu.get_JoulesGraphic

      let hasDram = T.Energy.Counter.Cpu.hasDram

      let hasGraphic = T.Energy.Counter.Cpu.hasGraphic
    end
  end

  type t = T.Energy.t Ctypes.structure Ctypes_static.ptr

  let default = T.mammut_getInstanceEnergy default

  let getCountersTypes ?energy:(e = default) () =
    let initial = allocate_n Types.counter_type ~count:1 in
    let arr = CArray.make ~initial (ptr Types.counter_type) 10 in
    let size = allocate int64_t 0L in
    T.Energy.getCountersTypes e (CArray.start arr) size ;
    let list =
      CArray.to_list (CArray.sub ~pos:0 ~length:(Int64.to_int !@size) arr)
    in
    List.map (fun a -> !@a) list

  let getCounterByType ?energy:(e = default) t =
    let res = T.Energy.getCounterByType e t in
    if is_null res then raise Not_found else res

  let getCounter ?energy:(e = default) () = T.Energy.getCounter e
end

module CpuFreq = struct
  type t = T.CpuFreq.t Ctypes.structure Ctypes_static.ptr

  let default = T.mammut_getInstanceCpuFreq default

  let enableBoosting ?cpufreq:(c = default) () = T.CpuFreq.enableBoosting c

  let disableBoosting ?cpufreq:(c = default) () = T.CpuFreq.disableBoosting c

  let isBoostingSupported ?cpufreq:(c = default) () =
    T.CpuFreq.isBoostingSupported c

  let isBoostingEnabled ?cpufreq:(c = default) () =
    T.CpuFreq.isBoostingEnabled c
end

(* kept just in case *)

let getInstanceEnergy = T.mammut_getInstanceEnergy

let getInstanceTopology = T.mammut_getInstanceTopology

let getInstanceCpuFreq = T.mammut_getInstanceCpuFreq
