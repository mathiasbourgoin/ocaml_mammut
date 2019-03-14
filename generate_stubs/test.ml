
open Ocaml_mammut

let rec fibo = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibo (n-1) + fibo (n-2)


let _ = 
  let m = create_Mammut () in
  let e = Mammut.getInstanceEnergy m in
  let c = Energy.getCounter e  in
  Unix.sleep(2);
  Printf.printf "%g joules consummed in the last 2 seconds \n%!" (Counter.getJoules c);
  Counter.reset c;
  Unix.sleep(4);
  Printf.printf "%g joules consummed in the last 4 seconds \n%!"(Counter.getJoulesCoresAll c);
  Counter.reset c;
  ignore(fibo 36);
  Printf.printf "%g joules consummed computing fibo 36 \n%!" (Counter.getJoulesCoresAll c);
  Counter.reset c;
  ignore(fibo 48);
  Printf.printf "%g joules consummed computing fibo 48 \n%!" (Counter.getJoulesDramAll c);
  ()

