open Mammut

let _ =
  let m = new mammut in
  let e = m#getInstanceEnergy in
  let c = e#getCounter in
  c#reset;
  Unix.sleep(2);
  Printf.printf "%g joules consummed in the last 2 seconds \n%!" c#getJoules;
  c#reset;
  Unix.sleep(4);
  Printf.printf "%g joules consummed in the last 4 seconds \n%!" c#getJoules;
  ()

  
