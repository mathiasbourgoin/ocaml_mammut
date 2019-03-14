open Ctypes
open Foreign

(**Object oriented binding to the mammut library *)

(** Mammut provides an object oriented abstraction of
  * architectural features normally exposed by means
  * of sysfs files or CPU registries.
  * It also provides the possibility to manage remote
  * machines by using a client server mechanism.

  * see http://danieledesensi.github.io/mammut/
  * for more info on mammut
*)

(**/**)
module Binding = struct

  type mammut
  type energy
  type counter

  type cpuid = int Ctypes.typ
  let cpuid : cpuid = Ctypes.int

  type joules = float Ctypes.typ
  let joules : joules = Ctypes.float



  let mammut : mammut structure typ = structure "Mammut"
  let energy : energy structure typ = structure "Energy"
  let counter : counter structure typ = structure "Counter"

  (** mammut.hpp *************************)
  (** class mammut *)
  let create_Mammut =
    foreign "create_Mammut" (void @-> returning (ptr mammut))
  let destroy_Mammut =
    foreign "destroy_Mammut" ((ptr mammut) @-> returning void)
  let mammut_getInstanceEnergy =
    foreign "getInstanceEnergy" (ptr mammut @-> returning (ptr energy))
  (************************* mammut.hpp **)

  let energy_getCounter =
    foreign "getCounter" (ptr energy @-> returning (ptr counter))

  let getType =
    foreign "getType" (ptr counter @-> returning int)
  let counter_reset =
    foreign "reset" (ptr counter @-> returning void)
  (* let counter_init =
   *   foreign "init" (ptr counter @-> returning bool) *)
  let counter_get_Joules =
    foreign "getJoules" (ptr counter @-> returning double)
  let counter_get_JoulesCpu  =
    foreign "getJoulesCpu" (ptr counter @-> cpuid @-> returning double)
  let counter_get_JoulesCpuAll =
    foreign "getJoulesCpuAll" (ptr counter @-> returning double)
  let counter_get_JoulesCores  =
    foreign "getJoulesCores" (ptr counter @-> cpuid @-> returning double)
  let counter_get_JoulesCoresAll =
    foreign "getJoulesCoresAll" (ptr counter @-> returning double)
  let counter_hasGraphic =
    foreign "hasJoulesGraphic" (ptr counter @-> returning bool)
  let counter_hasDram =
    foreign "hasJoulesDram" (ptr counter @-> returning bool)
  let counter_get_JoulesDram =
    foreign "getJoulesDram" (ptr counter @-> cpuid @-> returning double)
  let counter_get_JoulesDramAll =
    foreign "getJoulesDramAll" (ptr counter @-> returning double)
  let counter_get_JoulesGraphic =
    foreign "getJoulesGraphic" (ptr counter @-> cpuid @-> returning double)
  let counter_get_JoulesGraphicAll =
    foreign "getJoulesGraphicAll" (ptr counter @-> returning double)
end
(**/**)


type cpuid = int
type joules = float

(** Energy counter type *)
type counterType =
    CPU (** Power measured at CPU level *)
  | Plug (** Power measured at the plug*)

(** A generic energy counter *)
class counter c =
  let counterType =
    match Binding.getType c with
    | 0 -> CPU
    | 1 -> Plug
    | _ -> assert false
  in
  let getJoulesCpuAll,
      getJoulesCoresAll,
      getJoulesDramAll,
      getJoulesGraphicAll =
    match counterType with
    | CPU -> (fun c -> (Binding.counter_get_JoulesCpuAll c)),
             (fun c -> (Binding.counter_get_JoulesCoresAll c)),
             (fun c -> (Binding.counter_get_JoulesDramAll c)),
             (fun c -> (Binding.counter_get_JoulesGraphicAll c))
    | _ -> (fun c -> nan),
           (fun c -> nan),
           (fun c -> nan),
           (fun c -> nan)
  in
  let getJoulesCpu, getJoulesCores, getJoulesGraphic, getJoulesDram =
    match counterType with
    | CPU -> (fun c i -> (Binding.counter_get_JoulesCpu c i)),
             (fun c i -> (Binding.counter_get_JoulesCores c i)),
             (fun c i -> (Binding.counter_get_JoulesGraphic c i)),
             (fun c i -> (Binding.counter_get_JoulesGraphic c i))
    | _ -> (fun c i -> nan),
           (fun c i -> nan),
           (fun c i -> nan),
           (fun c i -> nan)
  in
  let hasJoulesDram,
      hasJoulesGraphic =
    match counterType with
    | CPU -> (fun c -> (Binding.counter_hasDram c)),
             (fun c -> (Binding.counter_hasGraphic c))

    | _ -> (fun c -> false),
           (fun c -> false)

  in
  object
    (**/**)
    val this = c
    (**/**)
    (** Returns the type of this counter
        @return The type of this counter *)
    method getType = counterType

    (** Resets the value of the counter.*)
    method reset = Binding.counter_reset this

    (** Initializes the counter.
        @return true if the counter is present, false otherwise.
    *)
    (* method init = Binding.counter_init this *)

    (** Returns the joules consumed up to this moment.
        @return The joules consumed up to this moment.*)
    method getJoules : joules = Binding.counter_get_Joules this

    (** Returns the Joules consumed by a Cpu since the counter creation
        (or since the last call of reset()).
        @param cpuId The identifier of a Cpu.
        @return The Joules consumed by a Cpu of type CpuCounter
        since the counter creation (or since the last call of reset()),
        or  nan for any other counter type.
    *)
    method getJoulesCpu (cpuid:cpuid) : joules = getJoulesCpu this cpuid

    (**  Returns the Joules consumed by all the Cpus since the counter creation
         or since the last call of reset()).
         @return The Joules consumed by all the Cpus of type CpuCounter
         since the counter creation (or since the last call of reset()),
         or  nan for any other counter type.
    *)
    method getJoulesCpuAll : joules = getJoulesCpuAll this

    (** Returns the Joules consumed by the cores of a Cpu since the counter creation
        (or since the last call of reset()).
        @param cpuId The identifier of a Cpu.
        @return The Joules consumed by the cores of a Cpu of type CpuCounter
        since the counter
        creation (or since the last call of reset())
        or nan for any other counter type.
    *)
    method getJoulesCores (cpuid:cpuid) : joules = getJoulesCores this cpuid

    (** Returns the Joules consumed by the cores of all the Cpus since the counter creation
        (or since the last call of reset()).
        @return The Joules consumed by the cores of all the Cpus of type CpuCounter
        since the counter
        creation (or since the last call of reset())
        or nan for any other counter type.
    *)
    method getJoulesCoresAll : joules = getJoulesCoresAll this

    (** Returns true if the counter for integrated graphic card is present, false otherwise.
        @return True if the counter for integrated graphic card is present, false otherwise.
    *)
    method hasJoulesGraphic  = hasJoulesGraphic this

    (** Returns the Joules consumed by a Cpu integrated graphic card (if present) since
        the counter creation (or since the last call of reset()).
        @param cpuId The identifier of a Cpu.
        @return The Joules consumed by a Cpu integrated graphic card (if present)
        since the counter creation (or since the last call of reset())
        or nan if not present.
    *)
    method getJoulesGraphic (cpuid : cpuid) : joules = getJoulesGraphic this cpuid

    (**  Returns the Joules consumed by all the Cpus integrated graphic card (if present) since
         the counter creation (or since the last call of reset()).
         @return The Joules consumed by all the Cpus integrated graphic card (if present)
         since the counter creation (or since the last call of reset())
         or nan if not present.
    *)
    method getJoulesGraphicAll : joules = getJoulesGraphicAll this

    (** Returns true if the counter for DRAM is present, false otherwise.
        @return True if the counter for DRAM is present, false otherwise.
    *)
    method hasJoulesDram = hasJoulesDram this

    (** Returns the Joules consumed by a Cpu Dram since the counter creation
        (or since the last call of reset()).
        @param cpuId The identifier of a Cpu.
        @return The Joules consumed by a Cpu Dram since the counter
        creation (or since the last call of reset())
        or nan if not present.
    *)
    method getJoulesDram (cpuid : cpuid) : joules = getJoulesDram this cpuid

    (** Returns the Joules consumed by all the Cpus Dram since the counter creation
        (or since the last call of reset()).
        @return The Joules consumed by all the Cpus Dram since the counter
        creation (or since the last call of reset())
        or nan if not present.
    *)
    method getJoulesDramAll : joules = getJoulesDramAll this
  end

class energy e =
  object
    val this = e
    method getCounter = new counter (Binding.energy_getCounter this)
  end

class mammut =
  object
    val this = Binding.create_Mammut();
      (** Returns an instance of the Energy module.
          @return An instance of the Energy module.
      *)
    method getInstanceEnergy = new energy (Binding.mammut_getInstanceEnergy this);
    initializer Gc.finalise Binding.destroy_Mammut this
  end
