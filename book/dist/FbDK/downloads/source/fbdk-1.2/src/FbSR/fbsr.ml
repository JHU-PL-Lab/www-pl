module Language = struct

  let name = "FbSR"
  module Parser = Fbsrparser
  module Lexer = Fbsrlexer
  module Ast = Fbsrast
  module Pp = Fbsrpp
  module Interpreter = Fbsrinterp

end;;

module Application = Application.Make(Language);;

Application.main ();;
