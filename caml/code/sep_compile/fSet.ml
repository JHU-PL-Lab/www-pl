exception NotFound

let rec add x s = x :: s
			
let rec remove x s = 
  match s with
    [] -> raise NotFound
  | hd :: tl -> 
      if hd = x then
	tl
      else
	hd :: remove x tl
	       
let rec contains x s = 
  match s with
    [] -> false
  | hd :: tl -> 
      if x = hd then
	true
      else
	contains x tl
	  
