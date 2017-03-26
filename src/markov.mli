(** There is constructing markov's chain. *)

(** The presentation for a word's distribution. *)
type distribution = {
  	total : int;
  	amounts : (string * int) list;
}

(** The type for a Markov's chain. *)
type ptable = {
  	prefix_length : int;
  	table : (string list, distribution) Hashtbl.t;
}

(** Check that it's a alphanumerical symbol. *)
val is_word : char -> bool

(** Check that it's a punctuation. *)
val is_punctuation : char -> bool

(** Chech that it's a separator between sentencies. *)
val is_sentence_separator : char -> bool

(** Split a string to a list of words. *)
val split_word : string -> string list

(** Make the list with few "START" words according to depth of chain's learning. *)
val start : int -> string list

(** Remove first element of a list and add new one to the end
    [1; 2; 3] 4 -> [2; 3; 4]
*)
val shift : 'a list -> 'a -> 'a list

(** Add new word to a chain. *)
val add_to : ('a, 'b list) Hashtbl.t -> 'a -> 'b -> unit

(** Construct a distribution from a list of words.*)
val compute_distribution : string list -> distribution

(** Find a continuation for a given word in a distribution. *)
val next_in_htable : ('a, distribution) Hashtbl.t -> 'a -> string

(** Take a list of words and a depth. Construct markov's chain. *)
val build_ptable : string list -> int -> ptable

(** Produce a random words' list from a given markov's chain. *)
val walk_ptable : ptable -> string list
