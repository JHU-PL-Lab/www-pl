    
    exception NotFound

    type 'a set = 'a list

    let emptyset : 'a set = []

    let rec add x (s: 'a set) = ((x :: s) : ('a set))
			    
    let rec remove x (s: 'a set) = 
      match s with
	[] -> raise NotFound
      | hd :: tl -> 
	  if hd = x then
	    tl
	  else
	    hd :: remove x tl
			    
    let rec contains x (s: 'a set) = 
      match s with
	[] -> false
      | hd :: tl -> 
	  if x = hd then
	    true
	  else
	    contains x tl