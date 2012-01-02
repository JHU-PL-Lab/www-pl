module Language = struct
  
  let name = "Fb"
  module Parser = Fbparser
  module Lexer = Fblexer
  module Ast = Fbast
  module Pp = Fbpp
  module Interpreter = Fbinterp

end;;

module Application = Application.Make(Language);;

Application.main ();;
