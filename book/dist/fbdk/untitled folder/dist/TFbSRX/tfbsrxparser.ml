
module MenhirBasics = struct
  
  exception Error
  
  let _eRR : exn =
    Error
  
  type token = 
    | WITH
    | TRY
    | THEN
    | SET
    | SEMI
    | RPAREN
    | REF
    | REC
    | RCURLY
    | RAISE
    | PLUS
    | OR
    | NOT
    | MINUS
    | LPAREN
    | LET
    | LCURLY
    | INTTYPE
    | INT of (
# 24 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (int)
# 32 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
  )
    | IN
    | IF
    | IDENT of (
# 21 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 39 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
  )
    | GOESTO
    | GET
    | FUNCTION
    | EXN of (
# 43 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 47 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
  )
    | EQUAL
    | EOEX
    | ELSE
    | DOT
    | COLON
    | BOOLTYPE
    | BOOL of (
# 13 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (bool)
# 58 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
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
  | MenhirState98
  | MenhirState95
  | MenhirState89
  | MenhirState87
  | MenhirState84
  | MenhirState81
  | MenhirState79
  | MenhirState73
  | MenhirState71
  | MenhirState69
  | MenhirState67
  | MenhirState65
  | MenhirState63
  | MenhirState61
  | MenhirState56
  | MenhirState52
  | MenhirState51
  | MenhirState50
  | MenhirState48
  | MenhirState46
  | MenhirState45
  | MenhirState44
  | MenhirState42
  | MenhirState37
  | MenhirState36
  | MenhirState34
  | MenhirState32
  | MenhirState30
  | MenhirState28
  | MenhirState27
  | MenhirState26
  | MenhirState19
  | MenhirState16
  | MenhirState12
  | MenhirState7
  | MenhirState6
  | MenhirState5
  | MenhirState4
  | MenhirState3
  | MenhirState2
  | MenhirState1
  | MenhirState0

# 1 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
  

open Tfbsrxast;;
open Tfbsrxpp;;


# 124 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"

[@@@ocaml.warning "-4-39"]

let rec _menhir_goto_record_body : _menhir_env -> 'ttv_tail -> _menhir_state -> ((Tfbsrxast.label * Tfbsrxast.expr) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState52 | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RCURLY ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : ((Tfbsrxast.label * Tfbsrxast.expr) list))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 122 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Record _2 )
# 145 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState84 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.label))), _, (_3 : (Tfbsrxast.expr))), _, (_5 : ((Tfbsrxast.label * Tfbsrxast.expr) list))) = _menhir_stack in
        let _v : ((Tfbsrxast.label * Tfbsrxast.expr) list) = 
# 135 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( (_1, _3)::_5 )
# 161 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_record_body _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run61 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState61 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState61 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState61 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState61
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState61

and _menhir_run63 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState63 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState63 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState63 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState63
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState63

and _menhir_run67 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState67 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState67 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState67 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState67
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState67

and _menhir_run69 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState69
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState69

and _menhir_run71 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState71

and _menhir_run73 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState73

and _menhir_run51 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState51 _v
    | BOOLTYPE ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState51 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState51 _v
    | INTTYPE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | LCURLY ->
        _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | LPAREN ->
        _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState51
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState51

and _menhir_run52 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState52 _v
    | RCURLY ->
        _menhir_run38 _menhir_env (Obj.magic _menhir_stack) MenhirState52
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState52

and _menhir_goto_exn_def : _menhir_env -> 'ttv_tail -> _menhir_state -> (string * Tfbsrxast.fbtype) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState4 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : (string * Tfbsrxast.fbtype))) = _menhir_stack in
            let _v : (string * Tfbsrxast.fbtype) = 
# 179 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       ( _2 )
# 456 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_exn_def _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState3 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BOOL _v ->
            _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
        | FUNCTION ->
            _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | GET ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | IDENT _v ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
        | IF ->
            _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | INT _v ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
        | LCURLY ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | LET ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | LPAREN ->
            _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | NOT ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | RAISE ->
            _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | REF ->
            _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | TRY ->
            _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState26
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState26)
    | MenhirState95 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | GOESTO ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                (match _tok with
                | BOOL _v ->
                    _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState98 _v
                | FUNCTION ->
                    _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | GET ->
                    _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | IDENT _v ->
                    _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState98 _v
                | IF ->
                    _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | INT _v ->
                    _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState98 _v
                | LCURLY ->
                    _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | LET ->
                    _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | LPAREN ->
                    _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | NOT ->
                    _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | RAISE ->
                    _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | REF ->
                    _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | TRY ->
                    _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState98
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState98)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_record_type : _menhir_env -> 'ttv_tail -> _menhir_state -> ((Tfbsrxast.label * Tfbsrxast.fbtype) list) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState52 | MenhirState7 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | RCURLY ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : ((Tfbsrxast.label * Tfbsrxast.fbtype) list))) = _menhir_stack in
            let _v : (Tfbsrxast.fbtype) = 
# 161 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( TRec _2 )
# 578 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_type_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState16 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.label))), _, (_3 : (Tfbsrxast.fbtype))), _, (_5 : ((Tfbsrxast.label * Tfbsrxast.fbtype) list))) = _menhir_stack in
        let _v : ((Tfbsrxast.label * Tfbsrxast.fbtype) list) = 
# 172 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( (_1, _3)::_5 )
# 594 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_record_type _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run18 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.fbtype) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.fbtype))) = _menhir_stack in
    let _v : (Tfbsrxast.fbtype) = 
# 163 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( TRef _1 )
# 608 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
     in
    _menhir_goto_type_decl _menhir_env _menhir_stack _menhir_s _v

and _menhir_run19 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.fbtype) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOLTYPE ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | INTTYPE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | LCURLY ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | LPAREN ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState19
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState19

and _menhir_goto_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState28 | MenhirState51 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 126 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( _2 )
# 657 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState61 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | COLON | ELSE | EOEX | RCURLY | RPAREN | SEMI | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))), _, (_3 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 98 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Set(_1, _3) )
# 691 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState63 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))), _, (_3 : (Tfbsrxast.expr))) = _menhir_stack in
        let _v : (Tfbsrxast.expr) = 
# 78 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Plus(_1, _3) )
# 707 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState67 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | COLON | ELSE | EOEX | RCURLY | RPAREN | SEMI | SET | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))), _, (_3 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 84 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Or(_1, _3) )
# 731 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState69 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))), _, (_3 : (Tfbsrxast.expr))) = _menhir_stack in
        let _v : (Tfbsrxast.expr) = 
# 80 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Minus(_1, _3) )
# 747 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState71 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | AND | COLON | ELSE | EOEX | EQUAL | OR | RCURLY | RPAREN | SEMI | SET | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))), _, (_3 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 88 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Equal(_1, _3) )
# 765 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState73 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | COLON | ELSE | EOEX | OR | RCURLY | RPAREN | SEMI | SET | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))), _, (_3 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 82 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( And(_1, _3) )
# 793 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState50 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | COLON | ELSE | EOEX | RCURLY | RPAREN | SEMI | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _, (_2 : (Tfbsrxast.ident))), _, (_4 : (Tfbsrxast.fbtype))), _, (_6 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 90 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Function(_2, _4, _6) )
# 825 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (_2 : (Tfbsrxast.expr))) = _menhir_stack in
        let _v : (Tfbsrxast.expr) = 
# 100 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Get _2 )
# 841 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState44 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | THEN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState79 _v
            | FUNCTION ->
                _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | GET ->
                _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | IDENT _v ->
                _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState79 _v
            | IF ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | INT _v ->
                _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState79 _v
            | LCURLY ->
                _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | LET ->
                _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | LPAREN ->
                _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | NOT ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | RAISE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | REF ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | TRY ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState79
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState79)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState79 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | ELSE ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
            | FUNCTION ->
                _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | GET ->
                _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | IDENT _v ->
                _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
            | IF ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | INT _v ->
                _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
            | LCURLY ->
                _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | LET ->
                _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | LPAREN ->
                _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | NOT ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | RAISE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | REF ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | TRY ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState81
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState81)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState81 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | COLON | ELSE | EOEX | RCURLY | RPAREN | SEMI | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _, (_2 : (Tfbsrxast.expr))), _, (_4 : (Tfbsrxast.expr))), _, (_6 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 94 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( If(_2, _4, _6) )
# 983 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SEMI ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState84 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState84)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | RCURLY ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.label))), _, (_3 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : ((Tfbsrxast.label * Tfbsrxast.expr) list) = 
# 133 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( [(_1, _3)] )
# 1026 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_record_body _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState36 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOLTYPE ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState87
            | INTTYPE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState87
            | LCURLY ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState87
            | LPAREN ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState87
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState87)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState89 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | COLON | ELSE | EOEX | RCURLY | RPAREN | SEMI | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((((_menhir_stack, _menhir_s), _, (_3 : (Tfbsrxast.ident))), _, (_4 : (Tfbsrxast.ident))), _, (_6 : (Tfbsrxast.fbtype))), _, (_8 : (Tfbsrxast.expr))), _, (_10 : (Tfbsrxast.fbtype))), _, (_12 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 92 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( LetRec(_3, _4, _6, _8, _10, _12) )
# 1098 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState27 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (_2 : (Tfbsrxast.expr))) = _menhir_stack in
        let _v : (Tfbsrxast.expr) = 
# 86 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Not _2 )
# 1114 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState26 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | COLON | ELSE | EOEX | RCURLY | RPAREN | SEMI | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _, (_2 : (string * Tfbsrxast.fbtype))), _, (_3 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 104 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( let (n, t) = _2 in Raise(n, t, _3) )
# 1140 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState2 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (_2 : (Tfbsrxast.expr))) = _menhir_stack in
        let _v : (Tfbsrxast.expr) = 
# 96 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Ref _2 )
# 1156 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | EXN _v ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState95 _v
            | LPAREN ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState95
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState95)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState98 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | COLON | ELSE | EOEX | RCURLY | RPAREN | SEMI | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((((_menhir_stack, _menhir_s), _, (_2 : (Tfbsrxast.expr))), _, (_4 : (string * Tfbsrxast.fbtype))), (_5 : (
# 21 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 1217 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
            ))), _, (_7 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 102 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( let (n, t) = _4 in Try(_2, n, Ident _5, t, _7) )
# 1222 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AND ->
            _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
        | EOEX ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 71 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
            ( _1 )
# 1245 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (Tfbsrxast.expr)) = _v in
            Obj.magic _1
        | EQUAL ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run69 _menhir_env (Obj.magic _menhir_stack)
        | OR ->
            _menhir_run67 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run63 _menhir_env (Obj.magic _menhir_stack)
        | SET ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_run42 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.label) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState42
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState42

and _menhir_run12 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.label) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOLTYPE ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | INTTYPE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | LCURLY ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | LPAREN ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState12
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState12

and _menhir_goto_type_decl : _menhir_env -> 'ttv_tail -> _menhir_state -> (Tfbsrxast.fbtype) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | GOESTO ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack)
        | REF ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack)
        | SEMI ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | IDENT _v ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState16 _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState16)
        | RCURLY ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.label))), _, (_3 : (Tfbsrxast.fbtype))) = _menhir_stack in
            let _v : ((Tfbsrxast.label * Tfbsrxast.fbtype) list) = 
# 170 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( [(_1, _3)] )
# 1354 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_record_type _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState50 | MenhirState19 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | GOESTO ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack)
        | REF ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack)
        | BOOL _ | EQUAL | FUNCTION | GET | IDENT _ | IF | IN | INT _ | LCURLY | LET | LPAREN | NOT | RAISE | RCURLY | RPAREN | SEMI | TRY ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.fbtype))), _, (_3 : (Tfbsrxast.fbtype))) = _menhir_stack in
            let _v : (Tfbsrxast.fbtype) = 
# 159 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( TArrow(_1, _3) )
# 1378 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_type_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState51 | MenhirState6 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | GOESTO ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack)
        | REF ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack)
        | RPAREN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _, (_2 : (Tfbsrxast.fbtype))) = _menhir_stack in
            let _v : (Tfbsrxast.fbtype) = 
# 165 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( _2 )
# 1404 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_type_decl _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState5 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | GOESTO ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack)
        | REF ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack)
        | BOOL _ | FUNCTION | GET | IDENT _ | IF | INT _ | LCURLY | LET | LPAREN | NOT | RAISE | RPAREN | TRY ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (
# 43 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 1427 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
            ))), _, (_2 : (Tfbsrxast.fbtype))) = _menhir_stack in
            let _v : (string * Tfbsrxast.fbtype) = 
# 177 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       ( (_1, _2) )
# 1432 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_exn_def _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState34 ->
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
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState36 _v
            | FUNCTION ->
                _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | GET ->
                _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | IDENT _v ->
                _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState36 _v
            | IF ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | INT _v ->
                _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState36 _v
            | LCURLY ->
                _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | LET ->
                _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | LPAREN ->
                _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | NOT ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | RAISE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | REF ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | TRY ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState36
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState36)
        | GOESTO ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack)
        | REF ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState48 ->
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
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _v
            | BOOLTYPE ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | FUNCTION ->
                _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | GET ->
                _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | IDENT _v ->
                _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _v
            | IF ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | INT _v ->
                _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState50 _v
            | INTTYPE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | LCURLY ->
                _menhir_run52 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | LET ->
                _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | LPAREN ->
                _menhir_run51 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | NOT ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | RAISE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | REF ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | TRY ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState50
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState50)
        | REF ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState87 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | GOESTO ->
            _menhir_run19 _menhir_env (Obj.magic _menhir_stack)
        | IN ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOL _v ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
            | FUNCTION ->
                _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | GET ->
                _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | IDENT _v ->
                _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
            | IF ->
                _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | INT _v ->
                _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
            | LCURLY ->
                _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | LET ->
                _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | LPAREN ->
                _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | NOT ->
                _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | RAISE ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | REF ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | TRY ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState89
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState89)
        | REF ->
            _menhir_run18 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_goto_appl_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_stack = Obj.magic _menhir_stack in
    assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState65
    | AND | COLON | ELSE | EOEX | EQUAL | MINUS | OR | PLUS | RCURLY | RPAREN | SEMI | SET | THEN | WITH ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))) = _menhir_stack in
        let _v : (Tfbsrxast.expr) = 
# 76 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( _1 )
# 1619 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState65

and _menhir_run56 : _menhir_env -> 'ttv_tail * _menhir_state * (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState56 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState56

and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | EXN _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState4 _v
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState4
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState4

and _menhir_run5 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 43 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 1657 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOLTYPE ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState5
    | INTTYPE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState5
    | LCURLY ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState5
    | LPAREN ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState5
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState5

and _menhir_run38 : _menhir_env -> 'ttv_tail * _menhir_state -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _v : (Tfbsrxast.expr) = 
# 124 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Record [] )
# 1685 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_run8 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 21 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 1692 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 21 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 1700 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
    )) = _v in
    let _v : (Tfbsrxast.label) = 
# 140 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Lab _1 )
# 1705 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState16 | MenhirState7 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState84 | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EQUAL ->
            _menhir_run42 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            _menhir_run12 _menhir_env (Obj.magic _menhir_stack)
        | EQUAL ->
            _menhir_run42 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState56 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))), _, (_3 : (Tfbsrxast.label))) = _menhir_stack in
        let _v : (Tfbsrxast.expr) = 
# 128 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Select(_3, _1) )
# 1757 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_run6 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOLTYPE ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | INTTYPE ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | LCURLY ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | LPAREN ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState6
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState6

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState7 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState7

and _menhir_run13 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Tfbsrxast.fbtype) = 
# 155 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( TInt )
# 1807 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
     in
    _menhir_goto_type_decl _menhir_env _menhir_stack _menhir_s _v

and _menhir_run14 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Tfbsrxast.fbtype) = 
# 157 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( TBool )
# 1818 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
     in
    _menhir_goto_type_decl _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_simple_expr : _menhir_env -> 'ttv_tail -> _menhir_state -> (Tfbsrxast.expr) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState0 | MenhirState98 | MenhirState1 | MenhirState2 | MenhirState26 | MenhirState27 | MenhirState28 | MenhirState89 | MenhirState36 | MenhirState42 | MenhirState81 | MenhirState79 | MenhirState44 | MenhirState45 | MenhirState50 | MenhirState73 | MenhirState71 | MenhirState69 | MenhirState67 | MenhirState63 | MenhirState61 | MenhirState51 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_run56 _menhir_env (Obj.magic _menhir_stack)
        | AND | BOOL _ | COLON | ELSE | EOEX | EQUAL | IDENT _ | INT _ | LCURLY | LPAREN | MINUS | OR | PLUS | RCURLY | RPAREN | SEMI | SET | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 109 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( _1 )
# 1839 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_appl_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState65 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | DOT ->
            _menhir_run56 _menhir_env (Obj.magic _menhir_stack)
        | AND | BOOL _ | COLON | ELSE | EOEX | EQUAL | IDENT _ | INT _ | LCURLY | LPAREN | MINUS | OR | PLUS | RCURLY | RPAREN | SEMI | SET | THEN | WITH ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.expr))), _, (_2 : (Tfbsrxast.expr))) = _menhir_stack in
            let _v : (Tfbsrxast.expr) = 
# 111 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Appl(_1,_2) )
# 1861 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
             in
            _menhir_goto_appl_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        _menhir_fail ()

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState98 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState95 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState89 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState87 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState84 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState81 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState79 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState73 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState71 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState69 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState67 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState65 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState63 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState61 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState56 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState51 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState50 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState48 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState46 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState44 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState42 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState36 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState34 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState30 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState28 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState27 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState26 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState19 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState16 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState7 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState6 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState5 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState4 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState3 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState2 ->
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
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | TRY ->
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
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState2 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState2
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState2

and _menhir_run3 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | EXN _v ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | LPAREN ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState3

and _menhir_run27 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState27

and _menhir_run28 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState28 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState28
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState28

and _menhir_run29 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | REC ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState30 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState30)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run37 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
    | RCURLY ->
        _menhir_run38 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState37

and _menhir_run43 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 24 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (int)
# 2249 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 24 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (int)
# 2257 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
    )) = _v in
    let _v : (Tfbsrxast.expr) = 
# 116 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Int _1 )
# 2262 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
     in
    _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_run44 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState44 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState44 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState44 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState44
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState44

and _menhir_run31 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 21 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 2306 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 21 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (string)
# 2314 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
    )) = _v in
    let _v : (Tfbsrxast.ident) = 
# 149 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Ident _1 )
# 2319 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
     in
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState30 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | IDENT _v ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState32 _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState32)
    | MenhirState32 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOLTYPE ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState34
            | INTTYPE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState34
            | LCURLY ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState34
            | LPAREN ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState34
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState34)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState46 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | COLON ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | BOOLTYPE ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState48
            | INTTYPE ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState48
            | LCURLY ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState48
            | LPAREN ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState48
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState48)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState0 | MenhirState98 | MenhirState1 | MenhirState2 | MenhirState26 | MenhirState27 | MenhirState28 | MenhirState89 | MenhirState36 | MenhirState42 | MenhirState81 | MenhirState79 | MenhirState44 | MenhirState45 | MenhirState50 | MenhirState73 | MenhirState71 | MenhirState69 | MenhirState67 | MenhirState65 | MenhirState63 | MenhirState61 | MenhirState51 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, (_1 : (Tfbsrxast.ident))) = _menhir_stack in
        let _v : (Tfbsrxast.expr) = 
# 144 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Var _1 )
# 2397 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_1 : (Tfbsrxast.expr)) = _v in
        let _v : (Tfbsrxast.expr) = 
# 120 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( _1 )
# 2405 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
         in
        _menhir_goto_simple_expr _menhir_env _menhir_stack _menhir_s _v
    | _ ->
        _menhir_fail ()

and _menhir_run45 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | BOOL _v ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState45

and _menhir_run46 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState46 _v
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState46

and _menhir_run54 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 13 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (bool)
# 2464 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (_1 : (
# 13 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
       (bool)
# 2472 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
    )) = _v in
    let _v : (Tfbsrxast.expr) = 
# 118 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
      ( Bool _1 )
# 2477 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
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

and main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Tfbsrxast.expr) =
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
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | FUNCTION ->
        _menhir_run46 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | GET ->
        _menhir_run45 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | IDENT _v ->
        _menhir_run31 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | IF ->
        _menhir_run44 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | INT _v ->
        _menhir_run43 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | LCURLY ->
        _menhir_run37 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LET ->
        _menhir_run29 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LPAREN ->
        _menhir_run28 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | NOT ->
        _menhir_run27 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | RAISE ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | REF ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | TRY ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)

# 180 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.mly"
  

# 2539 "dist/untitled folder/dist/TFbSRX/tfbsrxparser.ml"
