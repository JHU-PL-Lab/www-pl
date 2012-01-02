module Language = struct
  
  let name = "BOOL"
  module Parser = Boolparser
  module Lexer = Boollexer
  module Ast = Boolast
  module Pp = Boolpp
  module Interpreter = Boolinterp

end;;

module Application = Application.Make(Language);;

Application.main ();;
