type unknown
(** An opaque object containing a parsed JSON value. *)

val parse : string -> unknown
(** Parse a JSON string into an opaque value.

    @raise Exn.Syntax *)

val stringify : ?space:int -> unknown -> string
(** Serialize an opaque JSON object to a JSON string, optionally indenting it by
    [space] spaces. *)

(** A value that can be represented into JSON. *)
type value =
  | Null
  | Boolean of bool
  | Number of float
  | String of string
  | Array of value array
  | Object of value Dict.t

val to_value : unknown -> value
(** Parse an opaque JSON object into a {!value}. *)

val of_value : value -> unknown
(** Convert a {!value} into an opaque JSON object. *)

val parse_value : string -> value
(** Parse a JSON string into a {!value}.

    @raise Exn.Syntax *)
