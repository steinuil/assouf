(** Parse and serialize JSON. *)

module Unknown : sig
  (** Unsafe JSON functions. *)

  type t
  (** An opaque object containing a parsed JSON value. *)

  val parse : string -> t
  (** Parse a JSON string into an opaque value.

      @raise Exn.Syntax *)

  val stringify : ?space:int -> t -> string
  (** Serialize an opaque JSON object to a JSON string, optionally indenting it
      by [space] spaces. *)
end

(** A value that can be represented in JSON. *)
type t =
  | Null
  | Boolean of bool
  | Number of float
  | String of string
  | Array of t array
  | Object of t Dict.t

val of_unknown : Unknown.t -> t
(** Parse an opaque JSON object into a {!t}.

    @raise Exn.Type if the object does not conform to the JSON structure. *)

val to_unknown : t -> Unknown.t
(** Convert a {!t} into an opaque JSON object. *)

val of_string : string -> t
(** Parse a JSON string into a {!t}.

    Use the {!Decode} module to decode JSON into OCaml values.

    @raise Exn.Syntax *)

val to_string : ?space:int -> t -> string
(** Serialize a JSON value into a JSON string. *)
