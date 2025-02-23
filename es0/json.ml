external parse : string -> 'a = "parse"
[@@mel.scope "JSON"]
(** Parse a piece of string text as JSON and return the value. *)

external stringify :
  'a -> ?replacer:(string -> 'value -> _) -> ?space:int -> string = "stringify"
[@@mel.scope "JSON"]
(** Return a JSON string corresponding to the specified value. *)
