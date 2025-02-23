(** Operations for working with values that may be [null]. *)

type +'a t = 'a Js.null
(** A type that is either ['a] or [null]. *)

external return : 'a -> 'a t = "%identity"
(** Wraps a value as a [Null.t]. *)

external empty : 'a t = "#null"
(** The [null] value. *)

external to_option : 'a t -> 'a option = "#null_to_opt"
(** Maps ['a Null.t] to ['a option]. *)

external as_nullish : 'a t -> 'a Nullish.t = "%identity"
(** Cast to {!Nullish.t}. *)
