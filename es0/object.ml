(** Unsafe functions on JavaScript [Object]s. *)

type t
(** Any JavaScript [Object]. *)

external cast : _ -> t = "%identity"
(** Cast any value into an [Object]. *)

external assign : target:t -> source:t -> t = "assign"
[@@mel.scope "Object"]
(** Copies the values of all enumerable own properties from one or more source
    objects to a target object. *)

external get : t -> string -> _ = ""
[@@mel.get_index]
(** Get a property of an [Object]. *)

external global_this : 'a = "globalThis"
(** The [globalThis] property containing the global [this] value, which is
    usually akin to the global object. *)
