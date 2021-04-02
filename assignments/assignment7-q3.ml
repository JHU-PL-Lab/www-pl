(*

PoPL Assignment 7 question 3
Your Name : 
List of Collaborators :

In this file you will give your AFbV code for stack_behavior as an OCaml string.

*)

let stack_behavior = "(0 0)" (* fill in *)

let stack_tester = "
Let stack_behavior = "^stack_behavior^" In
Let stack_exercizer_behavior = 
  Fun me -> Fun _ -> Fun _ ->
    Let as = Create(stack_behavior,0) In
    (as <- `push(32,me));
    (Fun msg -> Match msg With 
      `return(_) -> 
        (as <- `push(22,me));
        (Fun msg -> Match msg With 
        `return(_) -> 
          (as <- `pop(me));
          (Fun msg -> Match msg With
           `some(x) -> If x = 22 Then Print \"Success\" Else Print \"Fail\"
          ))) In
Let a = Create(stack_exercizer_behavior,0) In a <- `anymessage(0)
"

(* Note that AFbV has list syntax built in which you may find convenient, you can write [1;2], Head l, Tail l, and test for empty with l = [].  There is no list pattern matching however. *)

(* `peu stack_tester` to test it.  Make sure to not include anything more than string definitions
        in this file for the autograder. *)
