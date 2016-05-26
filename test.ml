open Mammut

let rec fibo = function
  | 0 -> 0
  | 1 -> 1
  | n -> fibo (n-1) + fibo (n-2)

let _ =
  let m = new mammut in
  let e = m#getInstanceEnergy in
  let c = e#getCounter in
  c#reset;
  Unix.sleep(2);
  Printf.printf "%g joules consummed in the last 2 seconds \n%!" c#getJoulesCpuAll;
  c#reset;
  Unix.sleep(4);
  Printf.printf "%g joules consummed in the last 4 seconds \n%!" c#getJoulesCpuAll;
  c#reset;
  ignore(fibo 36);
  Printf.printf "%g joules consummed computing fibo 36 \n%!" c#getJoules;
  c#reset;
  ignore(fibo 48);
  Printf.printf "%g joules consummed computing fibo 48 \n%!" c#getJoulesDramAll;
  ()
