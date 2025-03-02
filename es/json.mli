type unknown
(** An opaque object containing a parsed JSON value. *)

val parse : string -> unknown
(** Parse a JSON string into an opaque value.

    @raise Exn.Syntax *)

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

val parse_value : string -> value
(** Parse a JSON string into a {!value}.

    @raise Exn.Syntax *)

module Decode : sig
  (** Decoders for safely decoding JSON into OCaml values.

      Monadic parser combinators for parsing JSON into OCaml values, inspired by Elm's
      {{:https://package.elm-lang.org/packages/elm/json/latest/Json-Decode} Json.Decode}
      module. *)

  (** {1 Types} *)

  (** A structured error describing how a decoder failed,
      parametrized by the input type. *)
  type 'a error =
    | Failed of string * 'a
      (** A generic decoding error. *)
    | Expected of string * 'a
      (** Expected a value of the type specified by the [string]. *)
    | Field of string * 'a error
      (** Failed while parsing a field of an object. *)
    | Index of int * 'a error
      (** Failed while parsing an item in an array. *)
    | One_of of 'a error array
      (** Tried several decoders with {!or_} or {!one_of} but they all failed. *)

  val value_error : unknown error -> value error
  (** Turn an error that occurred while decoding an opaque
      JSON value into an inspectable {!type-value}. *)

  type 'a t = unknown -> ('a, unknown error) Stdlib.Result.t
  (** A decoder for a JSON value. *)

  (** {1 Basic parsers} *)

  val unknown : unknown t
  (** Just return the unparsed opaque JSON value. *)

  val value : value t
  (** Parse the opaque JSON value into a {!type-value} and return it. *)

  val bool : bool t
  (** Parse a [bool]. *)

  val null_with : default:'a -> 'a t
  (** Parse [null] and replace it with [default]. *)

  val null : unit t
  (** Parse [null]. *)

  val float : float t
  (** Parse a [float]. *)

  val int : int t
  (** Parse an [int]. *)

  val string : string t
  (** Parse a [string]. *)

  val option : 'a t -> 'a option t
  (** Parse a value that may be [null] into an [option]. *)

  (** {1 Monadic operators} *)

  val return : 'a -> 'a t
  (** [return value] ignores the JSON value and return [value]. *)

  val fail : string -> 'a t
  (** [fail message] ignores the JSON value and fails with a [message]. *)

  val map : f:('a -> 'b) -> 'a t -> 'b t
  (** Create a parser from a 

      {[let string_length : int t = map ~f:String.length string]} *)

  val bind : f:('a -> 'b t) -> 'a t -> 'b t
  (** Create a decoder that depends on the output of another decoder. *)

  val both :'a t -> 'b t -> ('a * 'b) t
  val ( let* ) : 'a t -> ('a -> 'b t) -> 'b t
  val ( and* ) : 'a t -> 'b t -> ('a * 'b) t
  val or_ : 'a t -> 'a t -> 'a t
  val ( <|> ) : 'a t -> 'a t -> 'a t
  val one_of : 'a t array -> 'a t
  val array : 'a t -> 'a array t
  val dict : 'a t -> 'a Dict.t t
  val lazy_ : (unit -> 'a t) -> 'a t
  val field : string -> 'a t -> 'a t
  val index : int -> 'a t -> 'a t
  val optional : 'a t -> 'a option t
  val parse_with : decoder:'a t -> string -> ('a, value error) Stdlib.Result.t
end
