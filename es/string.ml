include Es0.String
(** @inline *)

external equal : string -> string -> bool = "%eq"

let char_code_at ~index s =
  let i = char_code_at ~index s in
  if Float.is_nan (Es0.Int.as_float i) then None else Some i

let index_of ~sub s = match index_of ~sub s with -1 -> None | i -> Some i

let last_index_of ~sub s =
  match last_index_of ~sub s with -1 -> None | i -> Some i
