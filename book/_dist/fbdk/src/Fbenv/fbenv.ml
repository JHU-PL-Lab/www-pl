module Language = struct

  (* This re-uses most of the Fb interpreter.  The Fbenv top loop fbenv.byte is also just fb.byte;
     use debugscript/fbenv.ml file to run the environment-based interpreter. *)

  let name = "Fbenv"
  module Parser = Fbparser
  module Lexer = Fblexer
  module Ast = Fbast
  module Pp = Fbpp
  module Options = Fboptions
  module Interpreter = Fbenvinterp
  module Analyzer = Fbenvanalysis
	module Typechecker = Fbtype

end;;

module Application = Application.Make(Language);;

Application.main ();;
