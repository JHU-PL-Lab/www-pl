(* Example of a main executable reading command line arguments.
*)

(** get file contents as a list of strings **)

let rec strings_from_file f =
    try
      let l = input_line f in
      l :: strings_from_file f
    with | _ -> []

let strings_from_file_name s =
      let file = open_in s in
      let st = strings_from_file file in
      let () = close_in file in
      st
      
(**  [do_search search_string filename] searches for a string line in file **)

let do_search search_string filename = 
  let s = strings_from_file_name filename in 
  let my_set = 
    List.fold_left 
      (fun set -> fun elt -> Simple_set.add elt set) 
      Simple_set.emptyset 
      s
    in
  if Simple_set.contains search_string my_set then 
    print_string @@ search_string^" found\n" 
  else print_string @@ search_string^" not found\n"

(* 
   The main program.
  let () = ... is a common idiom in a main module: the code will run when module loaded
  So, the code below de facto is the `main()` of our beloved C/Java/etc. world.
  You can also just directly put the code in with out the let (), but the parser
  can get confused as to whether it is part of the previous function or not. 
*)

let () = 
let search_string = Sys.argv.(1) in
let filename = Sys.argv.(2) in 
  do_search search_string filename



