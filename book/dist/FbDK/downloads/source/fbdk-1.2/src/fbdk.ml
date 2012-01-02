module type LANGUAGE = sig
  val name: string

  module Ast: sig
    type expr
  end

  module Parser: sig
    type token
    val main: 
     (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Ast.expr
  end

  module Lexer: sig
    val token: Lexing.lexbuf -> Parser.token
  end

  module Pp: sig
    val pretty_print: Ast.expr -> string
    val pp: Ast.expr -> string -> string
  end

  module Interpreter: sig
    val eval: Ast.expr -> Ast.expr
  end

end;;

