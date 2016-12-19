(*main project*)

open Cmdliner;;

type output = Stdout | Outfile of string;;

let string_of_output = function
  | Stdout -> "stdout"
  | Outfile file -> file;;

let learn fl =
  let str = Read.string_of_file fl in
  str;;

let main deep out files num =
  let fls = String.concat ", " (List.map learn files) in
  let outs = string_of_output out in
  Printf.printf "deep = %i\nout = %s\nfiles = %s\nnum = %i\n" deep outs fls num;;

let deep =
  let doc = "How deep the chain?" in
  Arg.(value & opt int 2 & info ["d"; "deep"] ~docv:"DEEP" ~doc);;

let out =
    let doc = "File to output the result." in
    let outfile =
      let parse s = `Ok (Outfile s) in
      parse, fun ppf o -> Format.fprintf ppf "%s" (string_of_output o) in
    Arg.(value & opt outfile Stdout & info ["o"; "output"] ~docv:"Outfile" ~doc);;

let files =
  Arg.(non_empty & pos_all file [] & info []  ~docv:"FILES");;

let num =
  (*Should be something like Infinite|Words of int| Lines of int*)
  let doc = "Maximum length of resutl text." in
  Arg.(value & opt int 0 & info ["n"; "num"] ~docv:"Amount of words" ~doc);;

let main_t = Term.(const main $ deep $ out $ files $ num);;

let info =
  let doc = "Make a random text" in
  let man = [`S "BUGS"; `P "email me";] in
  Term.info "bred" ~version:"0.0.1" ~doc ~man


let () = match Term.eval (main_t, info) with
  | `Error _ -> exit 1
  | _ -> exit 0;;
