let rec fibo = function 0 -> 0 | 1 -> 1 | n -> fibo (n - 1) + fibo (n - 2)

let print_joules c =
  let open Mammut.Energy in
  let joules = Counter.getJoules c
  and joulesCoreAll = Counter.Cpu.getJoulesCoresAll c
  and joulesDramAll = Counter.Cpu.getJoulesDramAll c
  and joulesGraphicAll = Counter.Cpu.getJoulesGraphicAll c in
  Printf.printf "  %g joules <--- getJoules \n" joules ;
  Printf.printf "  %g joules <--- getJoulesCoreAll \n" joulesCoreAll ;
  Printf.printf "  %g joules <--- getJoulesDramAll \n" joulesDramAll ;
  Printf.printf "  %g joules <--- getJoulesGraphicAll \n%!" joulesGraphicAll

let _ =
  let open Mammut in
  if CpuFreq.isBoostingSupported () then (
    Printf.printf "Boosting supported\n" ;
    CpuFreq.enableBoosting () ;
    Printf.printf "Test enable boosting : %b" (CpuFreq.isBoostingSupported ()) ;
    CpuFreq.disableBoosting () ;
    Printf.printf "Test disable boosting : %b" (CpuFreq.isBoostingSupported ()) )
  else Printf.printf "Boosting not supported :'( \n" ;
  let cpus = Topology.getCpus () in
  Printf.printf "Found %d CPUs\n%!" (List.length cpus) ;
  List.iteri
    (fun i cpu ->
      Printf.printf "CPU-%d%!" i ;
      Printf.printf
        " (Family %s - Model %s )\n%!"
        (Topology.Cpu.getFamily cpu)
        (Topology.Cpu.getModel cpu) )
    cpus ;
  let c = Energy.getCounter () in
  let available_types = Energy.getCountersTypes () in
  Printf.printf "Found counters of type : \n" ;
  List.iter
    (fun c -> Printf.printf "\t\t- %s\n" (Energy.Counter.type_to_string c))
    available_types ;
  Printf.printf "Try to get a CPU counter : %!" ;
  ( try
      ignore (Energy.getCounterByType Energy.Counter.CPU) ;
      Printf.printf "success \n%!"
    with _ -> Printf.printf "failure \n%!" ) ;
  ( Printf.printf "Try to get a Plug counter : %!" ;
    try
      ignore (Energy.getCounterByType Energy.Counter.Plug) ;
      Printf.printf "success \n%!"
    with _ -> Printf.printf "failure \n%!" ) ;
  let counterType = Energy.Counter.getType c in
  Printf.printf
    "Using default counter (type : %s)\n%!"
    (Energy.Counter.type_to_string counterType) ;
  Printf.printf "consummed sleeping for 2 seconds :\n%!" ;
  Unix.sleep 2 ;
  print_joules c ;
  Energy.Counter.reset c ;
  (* Printf.printf "consummed sleeping for 4 seconds :\n%!" ;
   * Unix.sleep 4 ;
   * print_joules c ;
   * Counter.reset c ; *)
  Printf.printf "consummed computing fibo 36 :\n%!" ;
  ignore (fibo 36) ;
  print_joules c ;
  (* Counter.reset c ;
   * Printf.printf "consummed computing fibo 48 :\n%!" ;
   * ignore (fibo 48) ;
   * print_joules c ; *)
  ()
