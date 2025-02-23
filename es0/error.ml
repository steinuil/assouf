(** The base JavaScript exception [Error]. *)

type t = Caml_js_exceptions.t
(** A JavaScript [Error] object. *)

external name : t -> string = "name"
[@@mel.get]
(** Represents the name for the type of error. *)

external message : t -> string = "message" [@@mel.get]
(** Error message. *)

external errors : t -> t array = "errors"
[@@mel.get]
(** The aggregated errors in an [AggregateError]. *)

external to_string : t -> string = "toString"
[@@mel.send]
(** Returns a string representing the [Error]. *)
