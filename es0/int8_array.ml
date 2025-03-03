type t

external make : length:int -> t = "Int8Array"
[@@mel.new]
(** Create a new Int8Array with the specified [length]. *)

external of_typed_array : int Typed_array.t -> t = "Int8Array" [@@mel.new]

external of_float_typed_array : float Typed_array.t -> t = "Int8Array"
[@@mel.new]

external of_iterable : int Iterable.t -> t = "Int8Array" [@@mel.new]

external of_iterable_map : 'a Iterable.t -> f:('a -> int) -> t = "from"
[@@mel.scope "Int8Array"]

external of_iterable_mapi : 'a Iterable.t -> f:('a -> int -> int) -> t = "from"
[@@mel.scope "Int8Array"]

external of_array_buffer : Array_buffer.t -> ?offset:int -> ?length:int -> t
  = "Int8Array"
[@@mel.new]

external as_typed_array : t -> int Typed_array.t = "%identity"
