open Ctypes
open Cstubs

module T = Generate_stubs.Bindings(Mammut_generated)

let create = T.create_Mammut
let destroy = T.destroy_Mammut
let getInstanceEnergy = T.mammut_getInstanceEnergy

module Energy = struct
  let getCounter = T.energy_getCounter
end

module Counter = struct
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
