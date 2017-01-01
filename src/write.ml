let generate_text chain =
  let text = Markov.walk_ptable chain in
  String.concat " " text;;
