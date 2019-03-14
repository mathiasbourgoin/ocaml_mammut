open Ctypes
open Cstubs

module T = Generate_stubs.Bindings(Mammut_generated)


let create_Mammut = T.create_Mammut

module Mammut = struct
  let getInstanceEnergy = T.mammut_getInstanceEnergy 
end

module Energy = struct
  let getCounter = T.energy_getCounter
end

module Counter = struct
  let reset = T.counter_reset
  let getJoules = T.counter_get_Joules
  let getJoulesCoresAll = T.counter_get_JoulesCoresAll
  let getJoulesDramAll = T.counter_get_JoulesDramAll
end
