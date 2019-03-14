
open Ocaml_mammut

let rec fibo = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibo (n-1) + fibo (n-2)


let print_joules = fun c ->
  let joules = Counter.getJoules c
  and joulesCoreAll = CounterCpus.getJoulesCoresAll c
  and joulesDramAll =  CounterCpus.getJoulesDramAll c 
  and joulesGraphicAll = CounterCpus.getJoulesGraphicAll c in
  Printf.printf "  %g joules <--- getJoules \n" joules ;
  Printf.printf "  %g joules <--- getJoulesCoreAll \n" joulesCoreAll ;
  Printf.printf "  %g joules <--- getJoulesDramAll \n" joulesDramAll ;
  Printf.printf "  %g joules <--- getJoulesGraphicAll \n" joulesGraphicAll 

let _ = 
  let m = Mammut.create () in
  let e = Mammut.getInstanceEnergy m in
  let c = Energy.getCounter e  in
  Unix.sleep(2) ;
  Printf.printf "consummed in the last 2 seconds \n%!" ;
  print_joules c ;
  Counter.reset c ;
  Unix.sleep(4) ;
  Printf.printf "consummed in the last 4 seconds \n%!" ;
  print_joules c ;
  Counter.reset c ;
  ignore(fibo 36);
  Printf.printf "consummed computing fibo 36 \n%!" ;
  print_joules c ;
  Counter.reset c;
  ignore(fibo 48);
  Printf.printf "consummed computing fibo 48 \n%!" ;
  print_joules c;
  ()

