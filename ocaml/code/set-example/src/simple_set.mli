(* 
  * The .mli file corresponding to an .ml file lets us hide certain elements of the module 
  * It is analogous to private/protected of Java etc
*)
    
    type 'a t (* hide the type 'a list here by not giving it in signature *)
    val emptyset : 'a t
    val add: 'a -> 'a t ->'a t
    val remove : 'a -> 'a t -> 'a t
    val contains: 'a -> 'a t -> bool    
