(** Helpers for encoding OCaml values into JSON. *)

open Json

(** Turn a [string] into a [Json.String]. *)
let string v = String v

(** Turn a [bool] into a [Json.Bool]. *)
let bool v = Boolean v

(** Turn an [int] into a [Json.Number]. *)
let int v = Number (Es0.Int.as_float v)

(** Turn a [float] into a [Json.Number]. *)
let float v = Number v

(** [Json.Null]. *)
let null = Null

(** If the value is [None], return a [Json.Null]. *)
let option f v = match v with Some v -> f v | None -> null

(** Turn an [array] into a [Json.Array]. *)
let array f arr = Array (Array.map ~f arr)

(** Turn a [Set] into a [Json.Array]. *)
let set f set = Array (Array.of_iterable_map ~f (Es0.Set.as_iterable set))

(** Turn an [Iterable] into a [Json.Array]. *)
let iterable f it = Array (Array.of_iterable_map ~f it)

(** Create a [Json.Object] from an array of (string * value). *)
let object_ arr = Object (Dict.of_array arr)

(** Turn a [Dict] into a [Json.Object]. *)
let dict dict = Object dict
