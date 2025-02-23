(** Operations for working with values that may be [undefined]. *)

type +'a t = 'a Js.undefined
(** A type that is either ['a] or [undefined]. *)

external return : 'a -> 'a t = "%identity"
(** Wraps a value as an [Undefined.t]. *)

external empty : 'a t = "#undefined"
(** The [undefined] value. *)

external to_option : 'a t -> 'a option = "#undefined_to_opt"
(** Maps ['a Undefined.t] to ['a option]. *)

external as_nullish : 'a t -> 'a Nullish.t = "%identity"
(** Cast to {!Nullish.t}. *)
