(* AFbV Actor programming by example *)

(* Use "ocamlrun afbv.byte --show-messages --show-states" to see the global actor universe as computation progresses, as well as messages as they are processed. In this debugging output the actors are named @1 @2 etc. *)

(* Here is a vey simple actor system: only one actor receiving one message *)

let onemsg = "Let oneMessage =
  Fun me -> (* First parameter is by contract the address of this actor *)
  Fun data -> (* Second parameter is the initial state value in Create, 2 here *)
  Fun msg -> (* Third parameter is .. finally .. the message packet coming in *)
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
                   Fun x -> x (* ignore this line for now, will explain later *)
     In
Let actor = Create(oneMessage,2) In
actor <- `doit(3)"
;;

(* will print OUTPUT: 5 *)

(* Note that parsing precedence is even worse in AFbV compared to previous languages!
   Moral: use many parentheses!! *)

(* Note if we send multiple messages to the above oneMessage actor 
   it will only process the first one: *)

let multbad = "Let oneMessage = Fun me -> Fun data -> Fun msg ->
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
                   Fun x -> x (* ignore this for now, it prevents an error message *)
     In
Let actor = Create(oneMessage,2) In
actor <- `doit(3);
actor <- `doit(7) (* will not be received - no code to process it *)"
;;


(* Why did the above fail?  Because the contract is: when the actor is finished processing,
   it needs to return what code will use to process the next message.  It doesn't just
   use the same code over and over like in object-oriented programming.
*)
   
(* Here is an example which processes multiple messages: 
  after the first message we return code to process the second.  *)

let twomsg = "Let twoMessages =
  Fun me -> Fun data -> Fun msg ->
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
     Fun msg -> ((Print \"DONE!\n\"); (Fun msg -> 0))
    In
Let actor = Create(twoMessages,2) In
actor <- `doit(3);
actor <- `doit(7) (* will run the DONE printing code *)"
;;
(* Note that me and data are for initialization only, the code we 
   install for subsequent messages is only Fun msg -> ... *)

(* A variation where we instead send one message to ourself using the special me variable *)

let twome = "Let actorBeh =
  Fun me -> Fun data -> Fun msg ->
     Match msg With
       `doit(_) ->
	   (Print \"OUTPUT: \"; (Print 0); Print \"\n\");
           (me <- (`onemoretime (0)));
	   (* here is the function return value which sets the next behavior *)
           (Fun msg -> (Match msg With `onemoretime (_) -> (Print data); (Fun msg -> 0))) In
Let actor = Create(actorBeh, 5) In
actor <- `doit (0)"
;;


(* Now, the above idea blows up if we want to process unbounded messages.
   Solution: use recursion to set the next code to 'this' code ! *)

(* Counting down example *)
(* Key compared to above is use Y combinator to name 'this code' *)
   
let countdown = " 
Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
Let countDown = Fun me ->  Fun data -> y (Fun this -> Fun msg ->
                                    Match msg With
                                        `count(n) ->
                                            (Print \"OUTPUT: \"; (Print n); Print \"\n\");
                                            (If n = 0 Then 0 Else (me <- (`count (n-1))));
                                            (this) (* key line - set next code to this *)
                               ) In
Let actor = Create(countDown, 0) In
actor <- `count 4"
;;

(* Internal state example: countdown where the actor internally keeps the count 
   Actors can be stateful in this manner: stateless during message processing but
   stateful between each message -- a hybrid of functional and imperative *)
   
let internal_count =  "Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
   Let actorBeh =

(* Observe how here the 'data' parameter is now under the Y - it is not just a global parameter,
   each recursion also needs to be fed data, and that will allow us to propagate state *)
   
  Fun me -> y (Fun this -> Fun data -> Fun msg ->
     Match msg With
       `count(_) ->
           (Print \"OUTPUT: \"; (Print data); Print \"\n\");
           (If data = 0 Then 0 Else (me <- (`count (_))));
           (this (data-1))) In
Let actor = Create(actorBeh, 4) In
actor <- `count (0)"
;;

(* ping pong example involving two actors.  Have pinger create ponger for fun. *)


let ping_pong = "
Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
Let behPong =
  Fun me -> y (Fun this -> Fun data -> Fun msg ->
     Match msg With
       `pong(n) ->
          (data <- (`ping (n+1))); (* invariant: data is pinger *)
          this data (* Use the same behavior for the next message received *)
                               ) In
Let behPing =
  Fun me -> Fun dummy -> Fun msg0 ->
 (* First message should be `init; create pong actor and get it going *)
     Match msg0 With
      `init(n) -> Let a2 = Create(behPong, me) In (* tell ponger about me when its made *)
	 (a2 <- `pong(n)); (* send pong an n-ball to start the game *)
         (* Now set behavior for rest of ping/pong game: get a ping, send a pong *)
         (y (Fun this -> Fun msg ->
            Match msg With `ping(n) ->
              (Print \"OUTPUT: \"; (Print n); Print \"\n\");
              (If n = 0 Then 0 Else (a2 <- (`pong (n-2))));
              this 
            )) In
Let a1 = Create(behPing, 0) In
a1 <- `init(4)"
;;



