open Ctypes
module Mt = Generate_types
module T = Mt.Types (Mammut_types)

module Bindings (F : Cstubs.FOREIGN) = struct
  type mammut

  let mammut : mammut structure typ = structure "MammutHandle"

  open F

  module Topology = struct
    module Cpu = struct
      type t

      let t : t structure typ = structure "MammutCpuHandle"

      let getFamily = foreign "getFamily" (ptr t @-> returning string)

      let getModel = foreign "getModel" (ptr t @-> returning string)

      let getCpuId = foreign "getCpuId" (ptr t @-> returning int32_t)
    end

    type t

    let t : t structure typ = structure "MammutTopologyHandle"

    let getCpus =
      foreign
        "getCpus"
        (ptr t @-> ptr (ptr (ptr Cpu.t)) @-> ptr int64_t @-> returning void)
  end

  module Energy = struct
    module Counter = struct
      type t

      let t : t structure typ = structure "MammutEnergyCounter"

      let get_Type = foreign "getType" (ptr t @-> returning T.counter_type)

      let reset = foreign "reset" (ptr t @-> returning void)

      let get_Joules = foreign "getJoules" (ptr t @-> returning double)

      module Cpu = struct
        let t : t structure typ = structure "MammutEnergyCounterCpus"

        let get_JoulesCpuAll =
          foreign "getJoulesCpuAll" (ptr t @-> returning double)

        let get_JoulesCpu =
          foreign
            "getJoulesCpu"
            (ptr t @-> ptr Topology.Cpu.t @-> returning double)

        let get_JoulesCoresAll =
          foreign "getJoulesCoresAll" (ptr t @-> returning double)

        let get_JoulesCores =
          foreign
            "getJoulesCores"
            (ptr t @-> ptr Topology.Cpu.t @-> returning double)

        let hasGraphic = foreign "hasJoulesGraphic" (ptr t @-> returning bool)

        let hasDram = foreign "hasJoulesDram" (ptr t @-> returning bool)

        let get_JoulesDramAll =
          foreign "getJoulesDramAll" (ptr t @-> returning double)

        let get_JoulesDram =
          foreign
            "getJoulesDram"
            (ptr t @-> ptr Topology.Cpu.t @-> returning double)

        let get_JoulesGraphicAll =
          foreign "getJoulesGraphicAll" (ptr t @-> returning double)

        let get_JoulesGraphic =
          foreign
            "getJoulesGraphic"
            (ptr t @-> ptr Topology.Cpu.t @-> returning double)
      end
    end

    type t

    let t : t structure typ = structure "MammutEnergyHandle"

    let getCountersTypes =
      foreign
        "getCountersTypes"
        (ptr t @-> ptr (ptr T.counter_type) @-> ptr int64_t @-> returning void)

    let getCounter = foreign "getCounter" (ptr t @-> returning (ptr Counter.t))

    let getCounterByType =
      foreign
        "getCounterByType"
        (ptr t @-> T.counter_type @-> returning (ptr Counter.t))
  end

  module CpuFreq = struct
    type t

    let t : t structure typ = structure "MammutCpuFreqHandle"

    let enableBoosting = foreign "enableBoosting" (ptr t @-> returning void)

    let disableBoosting = foreign "disableBoosting" (ptr t @-> returning void)

    let isBoostingEnabled =
      foreign "isBoostingEnabled" (ptr t @-> returning bool)

    let isBoostingSupported =
      foreign "isBoostingSupported" (ptr t @-> returning bool)
  end

  let create_Mammut = foreign "createMammut" (void @-> returning (ptr mammut))

  let destroy_Mammut = foreign "destroyMammut" (ptr mammut @-> returning void)

  let mammut_getInstanceEnergy =
    foreign "getInstanceEnergy" (ptr mammut @-> returning (ptr Energy.t))

  let mammut_getInstanceTopology =
    foreign "getInstanceTopology" (ptr mammut @-> returning (ptr Topology.t))

  let mammut_getInstanceCpuFreq =
    foreign "getInstanceCpuFreq" (ptr mammut @-> returning (ptr CpuFreq.t))
end
