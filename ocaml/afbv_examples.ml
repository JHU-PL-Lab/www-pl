
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

   then type `peu <example>` to run the example <example>.

*)

(* uncomment the following line to show messages as they are delivered; 
   this is the same as flag --show-messages on the binary. *)
(* show_messages := true;; *)

(* uncomment the following line to show the global state of the actor system as it evolves; 
   this is the same as flag --show-state on the binary. Actor names are a_1 a_2 etc here*)
(* show_states := true;; *)

(* uncomment the following line to force messages to be delivered in the order sent;
   this is the same as --deterministic on the binary. *)
(* deterministic_delivery := true;; *)

(* Here is a very simple actor system: only one actor receiving one message 
   Note the code is the "bootstrap" code which just sets up the initial actor system
   It is not run by any particular actor.  To make an interesting actor system
   the bootstrap code needs to create at least one actor and send it at least one message. 
*)

let onemsg = "Let one_message_behavior =
  Fun me -> (* First parameter is by contract the address of this actor *)
  Fun data -> (* Second parameter is the initial state value in Create, 2 here *)
  Fun msg -> (* Third parameter is .. finally .. the message packet coming in *)
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
                   Fun x -> x (* ignore this line for now, will explain later *)
In (* Above is just defining code, now lets bootstrap the system with some actual actors and messages *)
Let actor = Create(one_message_behavior,2) In
actor <- `doit(3)"
;;

(* peu onemsg will print OUTPUT: 5 *)

(* Note that parsing precedence is even worse in AFbV compared to previous languages!
   Moral: use many parentheses!! 
   Also, most annoyingly the string quotes need to be escaped in AFbV, the \"" in the above. *)

(* Note if we send multiple messages to the above one_message_behavior actor 
   it will only process one of them (nondeterministically): *)

let multbad = "Let one_message_behavior = Fun me -> Fun data -> Fun msg ->
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
                   Fun x -> x (* ignore this for now, it prevents an error message *)
     In
Let actor = Create(one_message_behavior,2) In
actor <- `doit(3);
actor <- `doit(7)"
;;
(* Nondeterminism is hard to debug so use this for debugging: `deterministic_delivery := true;;`
   - keeps message in a queue instead of a set conceptually *)


(* Why did the above not print out the 2nd OUTPUT message?  Because the contract is: when the actor is finished processing,
   it needs to return the code it will use to process the next message.  Here that code is a no-op identity function.
   So, it did in fact process it but the result was to not do anything.

   * This is similar to the hand-over-fist programming idiom for modifying functional trees, lists, etc
   * But, it is more general, it is the **code state** here.
   * In other words, the code you are setting is the future code for the actor
     - The PL term for "the rest of the code I need to run" is the **continuation**
     - So, each actor after processing one message needs to set its continuation before going back to sleep.
     - This is the same as how in JavaScript for asynchronous requests you need to set up the callback code
       -- the callback function is exactly the "next thing" the code needs to do, the **continuation**
       -- modern JavaScript has some sugar which hides this (asynch/await) but old JS and 
       under the covers there is a continuation function in JavaScript to perform subsequent actions
*)
   
(* Here is an example which processes multiple messages: 
  after the first message we **return code to process the second** -- the continuation code.  *)

let twomsg = "Let two_message_behavior =
  Fun me -> Fun data -> Fun msg ->
     Match msg With
       `doit(n) -> (Print \"OUTPUT: \"; (Print (n + data)); Print \"\n\");
     (* OK for the result we now return **code** (continuation) to process the next message *)
     (* This code is in turn what is installed in the soup so it will run upon next message *)  
     Fun msg -> ((Print \"DONE!\n\"); (Fun msg -> 0)) (* this return result will be code handling next message *)
    In
Let actor = Create(two_message_behavior,2) In
actor <- `doit(3);
actor <- `doit(7) (* will run the DONE printing code *)"
;;
(* Note that me and data are for initialization only, the code we 
   install for subsequent messages is only Fun msg -> ... *)

(* A variation where we instead send one message to ourself using the special me variable *)

let twome = "Let self_messaging_behavior =
  Fun me -> Fun _ -> Fun msg ->
     Match msg With
       `doit(_) ->
	   (Print \"OUTPUT: \"; (Print 0); Print \"\n\");
           (me <- (`onemoretime (1))); (* recall first parameter me is 'my own address' - message to self *)
	   (* here is the function return value which sets the next behavior *)
           (Fun msg -> (Match msg With `onemoretime (one) -> (Print \"MORE OUTPUT: \"; Print one); (Fun msg -> 0))) In
Let actor = Create(self_messaging_behavior, 00) In
actor <- `doit (00)"
;;


(* To close the loop, here is actual code for the refined a1/a2 example we worked in class.  
   Recall the way it went (this is the second version where a1 itself creates a2):

   1) in the bootstrap code we created actor a1 and sent a1 the message `hi(5)
   2) a1 handled the `hi(5) message, first creating actor a2 then sending `ho(6) to a2
   3) a2 then replied `ok(0) to a1.

   * Note that both a1 and a2 need to know each others' addresses to send each other messages
   * We can't in fact do the initial version of the example where we started with a1 and a2 
     both being created by the bootstrap code, because there is no syntax for mututal actor definition in AFbV.
*)   
let lecture_example = 
   "Let a1_behavior = 
       Let a2_behavior = Fun me -> Fun a1 -> Fun msg ->
          Match msg With
            `ho(n) -> 
                (Print \"DEBUG: a2 received ho\");
                (a1 <- `ok(0)); 
                (Fun msg -> 0) 
       In
       Fun me -> Fun data -> Fun msg ->
          Match msg With
            `hi(n) -> 
                (Print \"DEBUG: a1 received hi\");
                Let a2 = Create(a2_behavior, me) In  (* a1 creates a2, tells it about itself for reply *)
                (a2 <- `ho(6)); 
                Fun msg -> (Print \"DEBUG: a1 received ok\"); (Fun msg -> 0)
    In
    Let a1 = Create(a1_behavior,0) In
    a1 <- `hi(5)"
     ;;

(* The approach in the above examples of inlining next code fails if we want an actor to process unbounded messages.
   Solution: use recursion to set the next code to 'this' code ! *)

(* Counting down example *)
(* Key compared to above is use Y combinator to name 'this code' *)
   
let count_down = " 
Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
Let count_down_behavior = Fun me ->  Fun _ -> 
   y (Fun this -> Fun msg -> 
      Match msg With
      | `count(n) ->
         (Print \"OUTPUT: \"; (Print n); Print \"\n\");
         (If n = 0 Then 0 Else (me <- (`count (n-1))));
         (this) (* key line - set next code to this - like `this (n-1)` recursion but delay the n-1 *)
     ) In
Let actor = Create(count_down_behavior, 00) In
actor <- `count 4"
;;

(* Internal state example: count_down_behavior where the actor internally keeps the count 
   Actors can be stateful in this manner: stateless during message processing but
   stateful between each message.
   State is really just a parameter passed to the continuation each time, hand over fist.  *)
   
let internal_count =  "Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
   Let self_messaging_behavior =

(* Observe how here the 'cur_count' state parameter is now **under the Y** - it is not just a global parameter,
   each recursion also needs to be fed cur_count, and that will allow us to propagate state *)
   
  Fun me -> y (Fun this -> Fun cur_count -> Fun msg ->
     Match msg With
       `count(_) ->
           (Print \"OUTPUT: \"; (Print cur_count); Print \"\n\");
           (If cur_count = 0 Then 0 Else (me <- (`count (00))));
           (this (cur_count-1))) In
Let actor = Create(self_messaging_behavior, 4) In 
actor <- `count (00)"
;;


(* Count server example to show how one actor can maintain a data structure other
   actors can use.  For simplicity the data structure here is just a single number,
   incremented at each call *)

let count_server_eg =  "Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
Let count_beh = (* this actor behavior will be the count server *)
  Fun me -> y (Fun this -> Fun cur_count -> Fun msg ->
     Match msg With
       `count(a) -> (a <- cur_count);  (* send current count back to customer actor *)
                    (this (cur_count + 1)) (* change state to one bigger for next msg *)
   )
In
Let count_user_beh = (* This is a client to the above server, it will query for some numbers *)
  Fun me -> Fun count_actor -> Fun _ -> 
   count_actor <- `count(me); (* We critically need our own name here to let counter know where to send reply *)
   (Fun msg_n -> count_actor <- `count(me); (* this is the behavior to handle the reply, a number *)
   Fun msg_m -> Print \"OUTPUT: \"; Print(msg_n + msg_m)) (* One more behavior to handle reply to 2nd count *)
In
Let counter = Create(count_beh, 0) (* initial value is 0 *) In
Let user = Create(count_user_beh,counter) (* Need to tell user about count actor at its creation *) In
user <- 00 (* bootstrap the messaging by sending user any message *)"
;;


(* Ping pong example involving two actors.  Pinger creates ponger.
   Here they both can iterate unboundedly since both actors are recursions.
 *)

let ping_pong = "
Let y = (Fun b -> Let w = Fun s -> Fun m -> b (s s) m In w w) In
Let pong_behavior =
  Fun me -> Fun pinger -> y (Fun this -> Fun msg ->
     Match msg With
       `pong(n) ->
          (pinger <- (`ping (n))); (* invariant: pinger variable is pinger actor address *)
          this (* Use the same behavior for the next message received *)
                               ) In
Let ping_behavior = 
  Fun me -> Fun _ -> Fun msg0 ->
 (* First message should be `init; create pong actor and tell it how many balls to hit *)
     Match msg0 With
      `init(n) -> Let a2 = Create(pong_behavior, me) In (* tell ponger about me (pinger) when its made *)
	 (a2 <- `pong(n)); (* send pong an n-ball to start the game *)
         (* Now set behavior for rest of ping/pong game: get a ping, send a pong *)
         (y (Fun this -> Fun msg ->
            Match msg With `ping(n) ->
              (Print \"Pinger got ping numbered: \"; (Print n); Print \"\n\");
              (If n = 0 Then 0 Else (a2 <- (`pong (n-2))));
              this (* again use same behavior for next message *)
            )) In
Let a1 = Create(ping_behavior, 00) In
a1 <- `init(4)"
;;



