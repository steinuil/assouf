(** Arbitrary-precision unsigned integers. *)

type t

external of_int : int -> t = "BigInt"
(** Creates a BigInt from an int. *)

external of_string : string -> t = "BigInt"
(** Parses a string into a BigInt. *)

external as_int_n : t -> bits:int -> int = "asIntN"
[@@mel.scope "BigInt"]
(** Clamps a BigInt value to a signed integer value. *)

external as_uint_n : t -> bits:int -> int = "asUintN"
[@@mel.scope "BigInt"]
(** Clamps a BitInt value to an unsigned integer value. *)

external to_string : ?radix:int -> (t[@mel.this]) -> string = "toString"
[@@mel.send]
(** Returns a string representing the BigInt value in the specified radix
    ("base"). *)

external to_locale_string :
  ?locales:string ->
  ?options:Intl_number_format.options ->
  (t[@mel.this]) ->
  string = "toLocaleString"
[@@mel.send]
(** Returns a string with a language-sensitive representation of the BigInt. *)
