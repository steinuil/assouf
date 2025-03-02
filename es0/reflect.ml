external typeof :
  _ ->
  [ `undefined
  | `boolean
  | `number
  | `bigint
  | `string
  | `symbol
  | `\#function
  | `\#object ] = "#typeof"
(** The JavaScript [typeof] operator. Returns a string description of the
    primitive type of the object. *)

external is_array : 'a -> bool = "isArray"
[@@mel.scope "Array"]
(** Determine whether an object is an array. *)

external cast : 'a -> 'b = "%identity"
(** Perform an unsafe cast from one type to the other. *)

(* TODO *)
