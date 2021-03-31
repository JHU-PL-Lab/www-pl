
(* ************************************** *)
(* ****** Programming In AFbV *********** *)
(* ************************************** *)

(*   
   This file contains a series of AFbV example programs.  They are formatted
   as strings which can be parsed and evaluated using peu.

   To run these examples in the reference interpreter, first type

   $ ./reference/AFbV/toplevel.exe

   open Debugutils;;
   open Fbdk.Ast;;
   open Fbdk.Options;;

*)

(* uncomment the following line to show messages as they are delivered; 
   this is the same as flag --show-messages on the binary. *)
(* show_messages := true;; *)

(* uncomment the following line to show the global state of the actor system as it evolves; 
   this is the same as flag --show-state on the binary. Actor names are @1 @2 etc here*)
(* show_states := true;; *)

(* uncomment the following line to force messages to be delivered in the order sent;
   this is the same as --deterministic on the binary. *)
(* deterministic_delivery := true;; *)

(* Here is a very simple actor system: only one actor receiving one message 
   Note the code is the "bootstrap" code which just sets up the initial actor system
   It is not run by any particular actor.  To make an interesting actor system
   the bootstrap code needs to create at least one actor and send it at least one message. 
*)

let onemsg = "Let one_message_actor =
  Fun me -> (* First parameter is by contract the address of this actor *)
  Fun data -> (* Second parameter is the initial state value in Create, 2 here *)
  Fun msg -> (* Third parameter is .. finally .. the message packet coming in *)
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
                   Fun x -> x (* ignore this line for now, will explain later *)
     In
Let actor = Create(one_message_actor,2) In
actor <- `doit(3)"
;;

(* peu onemsg will print OUTPUT: 5 *)

(* Note that parsing precedence is even worse in AFbV compared to previous languages!
   Moral: use many parentheses!! *)

(* Note if we send multiple messages to the above one_message_actor actor 
   it will only process the first one: *)

let multbad = "Let one_message_actor = Fun me -> Fun data -> Fun msg ->
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
                   Fun x -> x (* ignore this for now, it prevents an error message *)
     In
Let actor = Create(one_message_actor,2) In
actor <- `doit(3);
actor <- `doit(7) (* will not be received - no code to process it *)"
;;


(* Why did the above fail?  Because the contract is: when the actor is finished processing,
   it needs to return what code will use to process the next message.  It doesn't just
   use the same code over and over like in object-oriented programming.
*)
   
(* Here is an example which processes multiple messages: 
  after the first message we return code to process the second.  *)

let twomsg = "Let two_message_actor =
  Fun me -> Fun data -> Fun msg ->
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
     Fun msg -> ((Print \"DONE!\n\"); (Fun msg -> 0))
    In
Let actor = Create(two_message_actor,2) In
actor <- `doit(3);
actor <- `doit(7) (* will run the DONE printing code *)"
;;
(* Note that me and data are for initialization only, the code we 
   install for subsequent messages is only Fun msg -> ... *)

(* A variation where we instead send one message to ourself using the special me variable *)

let twome = "Let self_messaging_actor =
  Fun me -> Fun data -> Fun msg ->
     Match msg With
       `doit(_) ->
	   (Print \"OUTPUT: \"; (Print 0); Print \"\n\");
           (me <- (`onemoretime (0)));
	   (* here is the function return value which sets the next behavior *)
           (Fun msg -> (Match msg With `onemoretime (_) -> (Print data); (Fun msg -> 0))) In
Let actor = Create(self_messaging_actor, 5) In
actor <- `doit (0)"
;;


(* Now, the above idea blows up if we want to process unbounded messages.
   Solution: use recursion to set the next code to 'this' code ! *)

(* Counting down example *)
(* Key compared to above is use Y combinator to name 'this code' *)
   
let count_down_actor = " 
Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
Let count_down_actor = Fun me ->  Fun data -> y (Fun this -> Fun msg ->
                                    Match msg With
                                        `count(n) ->
                                            (Print \"OUTPUT: \"; (Print n); Print \"\n\");
                                            (If n = 0 Then 0 Else (me <- (`count (n-1))));
                                            (this) (* key line - set next code to this *)
                               ) In
Let actor = Create(count_down_actor, 0) In
actor <- `count 4"
;;

(* Internal state example: count_down_actor where the actor internally keeps the count 
   Actors can be stateful in this manner: stateless during message processing but
   stateful between each message -- a hybrid of functional and imperative *)
   
let internal_count =  "Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
   Let self_messaging_actor =

(* Observe how here the 'data' parameter is now under the Y - it is not just a global parameter,
   each recursion also needs to be fed data, and that will allow us to propagate state *)
   
  Fun me -> y (Fun this -> Fun data -> Fun msg ->
     Match msg With
       `count(_) ->
           (Print \"OUTPUT: \"; (Print data); Print \"\n\");
           (If data = 0 Then 0 Else (me <- (`count (_))));
           (this (data-1))) In
Let actor = Create(self_messaging_actor, 4) In
actor <- `count (0)"
;;

(* ping pong example involving two actors.  Have pinger create ponger for fun. *)


let ping_pong = "
Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
Let pong_actor =
  Fun me -> y (Fun this -> Fun data -> Fun msg ->
     Match msg With
       `pong(n) ->
          (data <- (`ping (n+1))); (* invariant: data is pinger *)
          this data (* Use the same behavior for the next message received *)
                               ) In
Let ping_actor =
  Fun me -> Fun dummy -> Fun msg0 ->
 (* First message should be `init; create pong actor and get it going *)
     Match msg0 With
      `init(n) -> Let a2 = Create(pong_actor, me) In (* tell ponger about me when its made *)
	 (a2 <- `pong(n)); (* send pong an n-ball to start the game *)
         (* Now set behavior for rest of ping/pong game: get a ping, send a pong *)
         (y (Fun this -> Fun msg ->
            Match msg With `ping(n) ->
              (Print \"OUTPUT: \"; (Print n); Print \"\n\");
              (If n = 0 Then 0 Else (a2 <- (`pong (n-2))));
              this 
            )) In
Let a1 = Create(ping_actor, 0) In
a1 <- `init(4)"
;;



