(** The main project.
    Entrypoint and working with command line arguments. *)

(** Output could be to stdout or to a named file. *)
type output = out_channel -> bytes -> int -> int -> unit

(** Take filename and return it's content. *)                                                  
val learn: string -> string

(** Entrypoint for the bred program. *)
val main: int -> 'a -> string list -> 'b -> unit

(** CLI parameter to set deep of learning for the markov's chain. *)
val deep: int Cmdliner.Term.t

(** CLI parameter to set output file/stdout. *)
val out: output Cmdliner.Term.t

(** CLI parameter for list of files for chain's education. *)
val files: string list Cmdliner.Term.t

(** CLI parameter to limit length of output. *)
val num: int Cmdliner.Term.t

(** Build a CLI handler. *)
val main_t: unit Cmdliner.Term.t

(** Build an info page. *)
val info: Cmdliner.Term.info
