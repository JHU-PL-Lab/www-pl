module type S =
sig
	val main: unit -> unit
end

module Make(Lang: Fbdk.LANGUAGE) =
struct
	
	let toplevel_loop typechecking_enabled =
		Printf.printf "\t%s version %s\n\n"
			Lang.name Version.version;
		flush stdout;
		let typecheck_warning_printed = ref false in
		while true do
			Printf.printf "# ";
			flush stdout;
			let lexbuf = Lexing.from_channel stdin in
			let ast = Lang.Parser.main Lang.Lexer.token lexbuf in
			(
				try
					(
						match typechecking_enabled with
						| Some(true) ->
								let exprtype = Lang.Typechecker.typecheck ast in
								Printf.printf " :  %s\n" (Lang.Pp.pp_type exprtype "    ")
						| Some(false) -> ()
						| None ->
								let is_typechecking =
									(
										try
											ignore (Lang.Typechecker.typecheck ast); true
										with
										| Fbdk.TypecheckerNotImplementedException -> false
										| _ -> true
									)
								in
								if is_typechecking then
									if not !typecheck_warning_printed then
										(
											typecheck_warning_printed := true;
											print_string "Warning: typechecking disabled on command line.  See usage for more information.\n"
										)
									else
										()
								else ()
					)
				with Fbdk.TypecheckerNotImplementedException -> ()
			)
			;
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
		let typechecker = ref None in
		Arg.parse
			[("--version",
				Arg.Set(version),
				"show version information");
			("-t",
				Arg.Unit(fun () -> typechecker := Some(true)),
				"enables typechecking");
			("-T",
				Arg.Unit(fun () -> typechecker := Some(false)),
				"disables typechecking")]
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
			toplevel_loop (!typechecker)
		else
			run_file !filename
	
end
