(** The text generator module. *)

(** Take a markov's chain and generate output. *)
val generate_text: Markov.ptable -> string
