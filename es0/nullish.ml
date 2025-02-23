(** Operations for working with values that may be [undefined] or [null]. *)

type +'a t = 'a Js.nullable
(** A type that is one of ['a], [undefined] or [null]. *)

external return : 'a -> 'a t = "%identity"
(** Wraps a value as a [Nullish.t]. *)

external undefined : 'a t = "#undefined"
(** The [undefined] value, equivalent to {!Undefined.empty}. *)

external null : 'a t = "#null"
(** The [null] value, equivalent to {!Null.empty}. *)

external to_option : 'a t -> 'a option = "#nullable_to_opt"
(** Maps ['a Nullish.t] to ['a option]. *)
