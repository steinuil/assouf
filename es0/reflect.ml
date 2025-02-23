external typeof : _ -> string = "#typeof"
(** The JavaScript [typeof] operator. Returns a string description of the
    primitive type of the object. *)

external is_array : 'a -> bool = "isArray"
[@@mel.scope "Array"]
(** Determine whether an object is an array. *)

external cast : 'a -> 'b = "%identity"

(* TODO *)
