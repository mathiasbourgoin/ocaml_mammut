type t

val create : unit -> t

val destroy : t -> unit

val default : t

module Topology : sig
  module Cpu : sig
    type t

    val getFamily : t -> string

    val getModel : t -> string

    val getCpuId : t -> int32
  end

  type t

  val default : t

  val getCpus : ?topology:t -> unit -> Cpu.t list
end

module Energy : sig
  module Counter : sig
    type t

    type counter_type = CPU | Plug | Unknown of int64

    val type_to_string : counter_type -> string

    val getType : t -> counter_type

    val reset : t -> unit

    val getJoules : t -> float

    module Cpu : sig
      val getJoulesCpuAll : t -> float

      val getJoulesCpu : t -> Topology.Cpu.t -> float

      val getJoulesCoresAll : t -> float

      val getJoulesCores : t -> Topology.Cpu.t -> float

      val getJoulesDramAll : t -> float

      val getJoulesDram : t -> Topology.Cpu.t -> float

      val getJoulesGraphicAll : t -> float

      val getJoulesGraphic : t -> Topology.Cpu.t -> float

      val hasDram : t -> bool

      val hasGraphic : t -> bool
    end
  end

  type t

  val default : t

  val getCountersTypes : ?energy:t -> unit -> Counter.counter_type list

  val getCounterByType : ?energy:t -> Counter.counter_type -> Counter.t

  val getCounter : ?energy:t -> unit -> Counter.t
end

module CpuFreq : sig
  type t

  val default : t

  val enableBoosting : ?cpufreq:t -> unit -> unit

  val disableBoosting : ?cpufreq:t -> unit -> unit

  val isBoostingSupported : ?cpufreq:t -> unit -> bool

  val isBoostingEnabled : ?cpufreq:t -> unit -> bool
end

val getInstanceEnergy : t -> Energy.t

val getInstanceTopology : t -> Topology.t

val getInstanceCpuFreq : t -> CpuFreq.t
