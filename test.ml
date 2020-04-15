let rec fibo = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibo (n-1) + fibo (n-2)

let print_joules = fun c ->
  let open Mammut in
  let joules = Counter.getJoules c
  and joulesCoreAll = CounterCpus.getJoulesCoresAll c
  and joulesDramAll =  CounterCpus.getJoulesDramAll c 
  and joulesGraphicAll = CounterCpus.getJoulesGraphicAll c in
  Printf.printf "  %g joules <--- getJoules \n" joules ;
  Printf.printf "  %g joules <--- getJoulesCoreAll \n" joulesCoreAll ;
  Printf.printf "  %g joules <--- getJoulesDramAll \n" joulesDramAll ;
  Printf.printf "  %g joules <--- getJoulesGraphicAll \n%!" joulesGraphicAll

let _ =
  let open Mammut in
  let m = create () in
  let e = getInstanceEnergy m in
  let c = Energy.getCounter e  in
  Printf.printf "consummed sleeping for 2 seconds :\n%!" ;
  Unix.sleep(2) ;
  print_joules c ;
  Counter.reset c ;
  Printf.printf "consummed sleeping for 4 seconds :\n%!" ;
  Unix.sleep(4) ;
  print_joules c ;
  Counter.reset c ;
  Printf.printf "consummed computing fibo 36 :\n%!" ;
  ignore(fibo 36);
  print_joules c ;
  Counter.reset c;
  Printf.printf "consummed computing fibo 48 :\n%!" ;
  ignore(fibo 48);
  print_joules c;
  ()

