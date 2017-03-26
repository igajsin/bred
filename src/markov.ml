type distribution =
  { total : int ;
    amounts : (string * int) list };;

type ptable =
  { prefix_length : int ;
    table : (string list, distribution) Hashtbl.t };;

let is_word c =
  let idx = Char.code c in
  let is_ab idx =
    (idx > 47 && idx < 58)
    || (idx > 64 && idx < 91)
    || (idx > 96 && idx < 123)
    || (idx > 127) in
  is_ab idx;;

let is_punctuation c =
    List.mem c [';'; ','; ':'; '-'; '"'; '\''; '?'; '!' ; '.'] ;;

let is_sentence_separator c = List.mem c ['?'; '!'; '.'];;

let split_word str =
  let buf = Buffer.create 3 in
  let res = ref [] in
  let flash_buf ()=
    let word = Buffer.contents buf in
    if not (word = "") then
      (res := word :: !res;
       Buffer.clear buf) in
  let convert idx c =
    if is_word c then (*part of uninterrupted sequences*)
      Buffer.add_char buf c
    else if is_punctuation c then
      (flash_buf ();
       res := (String.make 1 c) :: !res)
    else (* is separator *)
      flash_buf () in
  begin
    String.iteri convert str;
    flash_buf ();
    List.rev !res
  end;;


let rec start = function
  | 0 -> []
  | n -> "START" :: start (n - 1);;

let shift words word =
  let base = match words with
    | [] -> []
    | x::xs -> xs in
  base @ [word];;

let add_to table k v =
  if Hashtbl.mem table k then
    let vs = Hashtbl.find table k in
    Hashtbl.replace table k (v::vs)
  else
    Hashtbl.add table k [v] ;;

let compute_distribution words =
  let (tot, am) = List.fold_left
    (fun (tot, am) word ->
      match am with
      | [] -> (tot + 1, [(word, 1)])
      | (w, count)::ws when w = word -> (tot + 1, (w, count + 1)::ws)
      | (w, count)::ws as wlist -> (tot + 1, (word, 1)::wlist))
    (0, []) (List.sort compare words) in
  {total = tot; amounts = am};;

let next_in_htable words word =
  let distribution = Hashtbl.find words word in
  let pos = Random.int distribution.total + 1 in
  let rec find_word pos = function
    | [] -> ""
    | (word, amount)::ws ->
       let new_pos = pos - amount in
       if new_pos > 0 then
         find_word new_pos ws
       else
         word in
  find_word pos distribution.amounts;;


let build_ptable words n =
  let table = Hashtbl.create 0 in
  let result = Hashtbl.create 0 in
  let last =
    List.fold_left
      (fun key x ->
        (add_to table key x;
        shift key x)) (start n) words in
  (add_to table last "STOP";
   Hashtbl.iter (fun k v -> Hashtbl.add result k (compute_distribution v)) table;
   {prefix_length = n; table = result});;

let walk_ptable ptable =
  let first = start ptable.prefix_length in
  let table = ptable.table in
  let rec step prevs =
    let word = next_in_htable table prevs in
    if word = "STOP" then []
    else
      word :: (step (shift prevs word)) in
  step first;;
