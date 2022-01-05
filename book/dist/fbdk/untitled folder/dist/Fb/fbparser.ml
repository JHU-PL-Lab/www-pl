
module MenhirBasics = struct
  
  exception Error
  
  let _eRR : exn =
    Error
  
  type token = 
    | THEN
    | RPAREN
    | REC
    | PLUS
    | OR
    | NOT
    | MINUS
    | LPAREN
    | LET
    | INT of (
# 21 "dist/untitled folder/dist/Fb/fbparser.mly"
       (int)
# 23 "dist/untitled folder/dist/Fb/fbparser.ml"
  )
    | IN
    | IF
    | IDENT of (
# 18 "dist/untitled folder/dist/Fb/fbparser.mly"
       (string)
# 30 "dist/untitled folder/dist/Fb/fbparser.ml"
  )
    | GOESTO
    | FUNCTION
    | EQUAL
    | EOEX
    | ELSE
    | BOOL of (
# 12 "dist/untitled folder/dist/Fb/fbparser.mly"
       (bool)
# 40 "dist/untitled folder/dist/Fb/fbparser.ml"
  )
    | AND
  
end

include MenhirBasics

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState45
  | MenhirState43
  | MenhirState40
  | MenhirState37
  | MenhirState35
  | MenhirState32
  | MenhirState30
  | MenhirState28
  | MenhirState26
  | MenhirState24
  | MenhirState22
  | MenhirState15
  | MenhirState13
  | MenhirState12
  | MenhirState10
  | MenhirState8
  | MenhirState6
  | MenhirState5
  | MenhirState4
  | MenhirState1
  | MenhirState0

# 1 "dist/untitled folder/dist/Fb/fbparser.mly"
  

open Fbast;;


# 84 "dist/untitled folder/dist/Fb/fbparser.ml"

[@@@ocaml.warning "-4-39"]

let rec _menhir_run22 : _menhir_env -> 'ttv_tail * _menhir_state * (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState22 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState22
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState22

and _menhir_run26 : _menhir_env -> 'ttv_tail * _menhir_state * (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState26
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState26

and _menhir_run28 : _menhir_env -> 'ttv_tail * _menhir_state * (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState28

and _menhir_run30 : _menhir_env -> 'ttv_tail * _menhir_state * (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState30 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState30
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState30 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState30
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState30 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState30
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState30
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState30
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState30
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState30

and _menhir_run32 : _menhir_env -> 'ttv_tail * _menhir_state * (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState32 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState32
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState32 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState32
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState32 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState32
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState32
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState32
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState32
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState32

and _menhir_goto_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState15 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | ELSE | EOEX | IN | RPAREN | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _, (_2 : (Fbast.ident))), _, (_4 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 72 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Function(_2, _4) )
# 253 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState22 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (Fbast.expr))), _, (_3 : (Fbast.expr))) = _menhir_stack in
        let _v : (Fbast.expr) = 
# 60 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Plus(_1, _3) )
# 269 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState26 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | ELSE | EOEX | IN | RPAREN | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Fbast.expr))), _, (_3 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 66 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Or(_1, _3) )
# 293 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState28 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (Fbast.expr))), _, (_3 : (Fbast.expr))) = _menhir_stack in
        let _v : (Fbast.expr) = 
# 62 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Minus(_1, _3) )
# 309 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState30 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | AND | ELSE | EOEX | EQUAL | IN | OR | RPAREN | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Fbast.expr))), _, (_3 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 70 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Equal(_1, _3) )
# 327 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | ELSE | EOEX | IN | OR | RPAREN | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Fbast.expr))), _, (_3 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 64 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( And(_1, _3) )
# 355 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
            | FUNCTION ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState35
            | IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
            | IF ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState35
            | INT _v ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
            | LET ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState35
            | LPAREN ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState35
            | MINUS ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState35
            | NOT ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState35
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState35)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState35 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | ELSE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
            | FUNCTION ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState37
            | IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
            | IF ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState37
            | INT _v ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
            | LET ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState37
            | LPAREN ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState37
            | MINUS ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState37
            | NOT ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState37
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState37)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | ELSE | EOEX | IN | RPAREN | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _, (_2 : (Fbast.expr))), _, (_4 : (Fbast.expr))), _, (_6 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 78 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( If(_2, _4, _6) )
# 481 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState10 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | IN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _v
            | FUNCTION ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState40
            | IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _v
            | IF ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState40
            | INT _v ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState40 _v
            | LET ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState40
            | LPAREN ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState40
            | MINUS ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState40
            | NOT ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState40
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState40)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState40 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | ELSE | EOEX | IN | RPAREN | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((((_menhir_stack, _menhir_s), _), _, (_3 : (Fbast.ident))), _, (_4 : (Fbast.ident))), _, (_6 : (Fbast.expr))), _, (_8 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 76 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( LetRec(_3, _4, _6, _8) )
# 559 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | IN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
            | FUNCTION ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState45
            | IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
            | IF ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState45
            | INT _v ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
            | LET ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState45
            | LPAREN ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState45
            | MINUS ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState45
            | NOT ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState45
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState45)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | ELSE | EOEX | IN | RPAREN | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _, (_2 : (Fbast.ident))), _, (_4 : (Fbast.expr))), _, (_6 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 74 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Let(_2, _4, _6) )
# 637 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState4 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 103 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( _2 )
# 669 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (_2 : (Fbast.expr))) = _menhir_stack in
        let _v : (Fbast.expr) = 
# 68 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Not _2 )
# 685 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run32 _menhir_env (Obj.magic _menhir_stack)
        | EOEX ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (_1 : (Fbast.expr))) = _menhir_stack in
            let _v : (Fbast.expr) = 
# 53 "dist/untitled folder/dist/Fb/fbparser.mly"
            ( _1 )
# 702 "dist/untitled folder/dist/Fb/fbparser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (Fbast.expr)) = _v in
            Obj.magic _1
        | EQUAL ->
            _menhir_run30 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run26 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run22 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_appl_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _v
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _v
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState24 _v
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState24
    | AND | ELSE | EOEX | EQUAL | IN | MINUS | OR | PLUS | RPAREN | THEN ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (_1 : (Fbast.expr))) = _menhir_stack in
        let _v : (Fbast.expr) = 
# 58 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( _1 )
# 751 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState24

and _menhir_goto_negatable_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = Obj.magic _menhir_stack in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (Fbast.expr)) = _v in
    let _v : (Fbast.expr) = 
# 83 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( _1 )
# 767 "dist/untitled folder/dist/Fb/fbparser.ml"
     in
    _menhir_goto_appl_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_simple_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> (Fbast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState0 | MenhirState1 | MenhirState4 | MenhirState45 | MenhirState43 | MenhirState40 | MenhirState10 | MenhirState37 | MenhirState35 | MenhirState12 | MenhirState32 | MenhirState30 | MenhirState28 | MenhirState26 | MenhirState22 | MenhirState15 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_1 : (Fbast.expr)) = _v in
        let _v : (Fbast.expr) = 
# 92 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( _1 )
# 781 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        _menhir_goto_negatable_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_2 : (Fbast.expr)) = _v in
        let (_menhir_stack, _menhir_s, (_1 : (Fbast.expr))) = _menhir_stack in
        let _v : (Fbast.expr) = 
# 85 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Appl(_1,_2) )
# 792 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        _menhir_goto_appl_expr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState40 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState35 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState30 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState28 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState26 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState24 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState22 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState15 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState10 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState8 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState6 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState5 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState4 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState1

and _menhir_run2 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | INT _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_2 : (
# 21 "dist/untitled folder/dist/Fb/fbparser.mly"
       (int)
# 927 "dist/untitled folder/dist/Fb/fbparser.ml"
        )) = _v in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _v : (Fbast.expr) = 
# 90 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Int (-_2) )
# 933 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        _menhir_goto_negatable_expr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState4
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState4
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState4
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState4
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState4
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState4
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState4

and _menhir_run5 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState5 _v
    | REC ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_s = MenhirState5 in
        let _menhir_stack = (_menhir_stack, _menhir_s) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState6)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState5

and _menhir_run11 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 21 "dist/untitled folder/dist/Fb/fbparser.mly"
       (int)
# 1001 "dist/untitled folder/dist/Fb/fbparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 21 "dist/untitled folder/dist/Fb/fbparser.mly"
       (int)
# 1009 "dist/untitled folder/dist/Fb/fbparser.ml"
    )) = _v in
    let _v : (Fbast.expr) = 
# 97 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Int _1 )
# 1014 "dist/untitled folder/dist/Fb/fbparser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_run12 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState12

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 18 "dist/untitled folder/dist/Fb/fbparser.mly"
       (string)
# 1050 "dist/untitled folder/dist/Fb/fbparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 18 "dist/untitled folder/dist/Fb/fbparser.mly"
       (string)
# 1058 "dist/untitled folder/dist/Fb/fbparser.ml"
    )) = _v in
    let _v : (Fbast.ident) = 
# 113 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Ident _1 )
# 1063 "dist/untitled folder/dist/Fb/fbparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState6 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState8)
    | MenhirState8 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _v
            | FUNCTION ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState10
            | IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _v
            | IF ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState10
            | INT _v ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState10 _v
            | LET ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState10
            | LPAREN ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState10
            | MINUS ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState10
            | NOT ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState10
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState10)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | GOESTO ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState15 _v
            | FUNCTION ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState15
            | IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState15 _v
            | IF ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState15
            | INT _v ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState15 _v
            | LET ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState15
            | LPAREN ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState15
            | MINUS ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState15
            | NOT ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState15
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState15)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState0 | MenhirState1 | MenhirState4 | MenhirState45 | MenhirState43 | MenhirState40 | MenhirState10 | MenhirState37 | MenhirState35 | MenhirState12 | MenhirState32 | MenhirState30 | MenhirState28 | MenhirState26 | MenhirState24 | MenhirState22 | MenhirState15 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (_1 : (Fbast.ident))) = _menhir_stack in
        let _v : (Fbast.expr) = 
# 108 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Var _1 )
# 1161 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_1 : (Fbast.expr)) = _v in
        let _v : (Fbast.expr) = 
# 101 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( _1 )
# 1169 "dist/untitled folder/dist/Fb/fbparser.ml"
         in
        _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState5 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | EQUAL ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
            | FUNCTION ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState43
            | IDENT _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
            | IF ->
                _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState43
            | INT _v ->
                _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
            | LET ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState43
            | LPAREN ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState43
            | MINUS ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState43
            | NOT ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState43
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState43)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run13 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13

and _menhir_run16 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 12 "dist/untitled folder/dist/Fb/fbparser.mly"
       (bool)
# 1227 "dist/untitled folder/dist/Fb/fbparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 12 "dist/untitled folder/dist/Fb/fbparser.mly"
       (bool)
# 1235 "dist/untitled folder/dist/Fb/fbparser.ml"
    )) = _v in
    let _v : (Fbast.expr) = 
# 99 "dist/untitled folder/dist/Fb/fbparser.mly"
      ( Bool _1 )
# 1240 "dist/untitled folder/dist/Fb/fbparser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Fbast.expr) =
  fun lexer lexbuf ->
    let _menhir_env = {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = Obj.magic ();
      _menhir_error = false;
    } in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | FUNCTION ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | IDENT _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | IF ->
        _menhir_run12 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | INT _v ->
        _menhir_run11 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | LET ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | MINUS ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | NOT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)

# 116 "dist/untitled folder/dist/Fb/fbparser.mly"
  

# 1294 "dist/untitled folder/dist/Fb/fbparser.ml"
