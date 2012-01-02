module type S =
  sig
    val main: unit -> unit
  end

module Make(Lang: Fbdk.LANGUAGE) =
  struct

    let toplevel_loop () =
      Printf.printf "\t%s version %s\n\n" 
        Lang.name Version.version;
      flush stdout;
      while true do
        Printf.printf "# ";
        flush stdout;
        let lexbuf = Lexing.from_channel stdin in
        let ast = Lang.Parser.main Lang.Lexer.token lexbuf in
        let result = Lang.Interpreter.eval ast in
        Printf.printf "==> %s\n" (Lang.Pp.pp result "    ");
        flush stdout
      done


    let run_file filename = 
      let fin = open_in filename in
      let lexbuf = Lexing.from_channel fin in
      let ast = Lang.Parser.main Lang.Lexer.token lexbuf in
      let result = Lang.Interpreter.eval ast in
      Printf.printf "%s\n" (Lang.Pp.pretty_print result);
      flush stdout

    let print_version () = 
      Printf.printf "%s version %s\nBuild Date: %s\n"
        Lang.name Version.version Version.date
        
    let main () = 
      let filename = ref "" in
      let toplevel = ref true in
      let version = ref false in
      Arg.parse 
        [("--version", 
          Arg.Set(version), 
          "show version information")] 
        (function fname -> 
          filename := fname; 
          version := false;
          toplevel := false)
        ("Usage: " ^ 
         Lang.name ^ 
         " [ options ] [ filename ]\noptions:");
      
      if !version then
        print_version ()
      else if !toplevel then
        toplevel_loop ()
      else
        run_file !filename

  end
