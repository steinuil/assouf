(** Operations on booleans. *)

type t = bool
(** The JavaScript
    {{:https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean}
     [Boolean]} type. *)

external of_int : int -> t = "Boolean"
(** [of_int i] is the same as [i <> 0]. *)

external of_float : float -> t = "Boolean"
(** [of_float f] is [false] if [f = Float.nan] or [f = 0.], [true] otherwise. *)

external to_string : t -> string = "toString"
[@@mel.send]
(** Returns ["true"] for [true], ["false"] for [false]. *)
