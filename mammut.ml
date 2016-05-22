open Ctypes
open Foreign

module Binding = struct
  
  type mammut
  type energy
  type counter
    
  type joules = float



  let mammut : mammut structure typ = structure "Mammut"
  let energy : energy structure typ = structure "Energy"
  let counter : counter structure typ = structure "Counter"
      
  let create_Mammut =
    foreign "create_Mammut" (void @-> returning (ptr mammut))
      
  let mammut_getInstanceEnergy =
    foreign "getInstanceEnergy" (ptr mammut @-> returning (ptr energy))

  let energy_getCounter =
    foreign "getCounter" (ptr energy @-> returning (ptr counter))


  let counter_reset =
    foreign "reset" (ptr counter @-> returning void)
  let counter_get_Joules =
    foreign "getJoules" (ptr counter @-> returning double)
  
end

class counter c =
  object
    val this = c
    method reset = Binding.counter_reset this
    method getJoules = Binding.counter_get_Joules this
  end
  
class energy e =
  object
    val this = e
    method getCounter = new counter (Binding.energy_getCounter this)
  end

class mammut =
  object
    val this = Binding.create_Mammut();
    method getInstanceEnergy = new energy (Binding.mammut_getInstanceEnergy this);
  end




