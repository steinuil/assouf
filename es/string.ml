open Es0

external equal : string -> string -> bool = "%eq"

include String
(** @inline *)

let char_code_at ~index s =
  let i = String.char_code_at ~index s in
  if Float.is_nan (Int.as_float i) then None else Some i

let index_of ~sub s =
  match String.index_of ~sub s with -1 -> None | i -> Some i

let last_index_of ~sub s =
  match String.last_index_of ~sub s with -1 -> None | i -> Some i
