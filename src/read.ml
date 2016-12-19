let string_of_file file =
  let input = open_in file in
  let result = ref "" in
  try
    while true do
      result := !result ^ " " ^ (input_line input)
    done; ""
  with End_of_file ->
    close_in input;
    !result;;

    
    
  
