open Cmdliner;;

let depth_arg =
  let doc ="Please give a positive number for set depth of chain." in
  Arg.(value & opt int 2 & info ["n"; "num"] ~docv:"depth" ~doc);;

let main n = ();;

let main_t = Term.(const main $ depth_arg);;

let info =
  let doc = "Random text generator" in
  let man = [`S "Bugs"; `P "mail me to igor@gajsin.name;"] in
  Term.info "bred" ~version:"0.0.1" ~doc ~man;;

let () = match Term.eval (main_t, info) with
  | `Error _ -> exit 1
  | _ -> exit 0;;
