echo let version = "1.1" > src\version.ml
echo let date = "unknown" >> src\version.ml
ocamlyacc -v src\Fb\fbparser.mly
ocamllex src\Fb\fblexer.mll
ocamlyacc -v src\FbSR\fbsrparser.mly
ocamllex src\FbSR\fbsrlexer.mll
ocamlyacc -v src\BOOL\boolparser.mly
ocamllex src\BOOL\boollexer.mll
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\version.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\fbdk.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\application.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\Fb\fbast.ml
ocamlc -c -g -I src -I src\Fb -I src\FbSR -I src\BOOL src\Fb\fbast.ml
ocamlc -c -g -I src -I src\Fb -I src\FbSR -I src\BOOL src\Fb\fbparser.mli
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\Fb\fbparser.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\Fb\fbpp.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\Fb\fblexer.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\Fb\fbinterp.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\Fb\fb.ml
ocamlc -I src -I src\Fb -I src\FbSR -I src\BOOL -o src\Fb\fb.opt src\version.cmo src\application.cmo src\fbdk.cmo src\Fb\fbast.cmo src\Fb\fbparser.cmo src\Fb\fbpp.cmo src\Fb\fblexer.cmo src\Fb\fbinterp.cmo src\Fb\fb.cmo
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\FbSR\fbsrast.ml
ocamlc -c -g -I src -I src\Fb -I src\FbSR -I src\BOOL src\FbSR\fbsrast.ml
ocamlc -c -g -I src -I src\Fb -I src\FbSR -I src\BOOL src\FbSR\fbsrparser.mli
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\FbSR\fbsrparser.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\FbSR\fbsrpp.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\FbSR\fbsrlexer.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\FbSR\fbsrinterp.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\FbSR\fbsr.ml
ocamlc -I src -I src\Fb -I src\FbSR -I src\BOOL -o src\FbSR\fbsr.opt src\version.cmo src\application.cmo src\fbdk.cmo src\FbSR\fbsrast.cmo src\FbSR\fbsrparser.cmo src\FbSR\fbsrpp.cmo src\FbSR\fbsrlexer.cmo src\FbSR\fbsrinterp.cmo src\FbSR\fbsr.cmo
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\BOOL\boolast.ml
ocamlc -c -g -I src -I src\Fb -I src\FbSR -I src\BOOL src\BOOL\boolast.ml
ocamlc -c -g -I src -I src\Fb -I src\FbSR -I src\BOOL src\BOOL\boolparser.mli
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\BOOL\boolparser.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\BOOL\boolpp.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\BOOL\boollexer.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\BOOL\boolinterp.ml
ocamlc -c -I src -I src\Fb -I src\FbSR -I src\BOOL src\BOOL\bool.ml
ocamlc -I src -I src\Fb -I src\FbSR -I src\BOOL -o src\BOOL\bool.opt src\version.cmo src\application.cmo src\fbdk.cmo src\BOOL\boolast.cmo src\BOOL\boolparser.cmo src\BOOL\boolpp.cmo src\BOOL\boollexer.cmo src\BOOL\boolinterp.cmo src\BOOL\bool.cmo
copy /Y src\Fb\fb.opt .\Fb
copy /Y src\FbSR\fbsr.opt .\FbSR
copy /Y src\BOOL\bool.opt .\BOOL
