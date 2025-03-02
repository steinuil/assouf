open Json

(** Decoders for safely decoding JSON into OCaml values.

    Monadic parser combinators for parsing JSON into OCaml values, inspired by
    Elm's
    {{:https://package.elm-lang.org/packages/elm/json/latest/Json-Decode}
     Json.Decode} module. *)

(** {1 Types} *)

(** A structured error describing how a decoder failed, parametrized by the
    input type. *)
type 'a error =
  | Failed of string * 'a  (** A generic decoding error. *)
  | Expected of string * 'a
      (** Expected a value of the type specified by the [string]. *)
  | Field of string * 'a error
      (** Failed while parsing a field of an object. *)
  | Index of int * 'a error  (** Failed while parsing an item in an array. *)
  | One_of of 'a error array
      (** Tried several decoders with {!or_} or {!one_of} but they all failed.
      *)

val value_error : unknown error -> value error
(** Turn an error that occurred while decoding an opaque JSON value into an
    inspectable {!type-value}. *)

type 'a t = unknown -> ('a, unknown error) Stdlib.Result.t
(** A decoder for a JSON value. *)

(** {1 Parse JSON} *)

val parse : decoder:'a t -> string -> ('a, value error) Stdlib.Result.t
(** Parse a JSON string and decode it using a decoder. *)

(** {1 Basic decoders} *)

val unknown : unknown t
(** Just return the unparsed opaque JSON value. *)

val value : value t
(** Parse the opaque JSON value into a {!type-value} and return it. *)

val bool : bool t
(** Decode a [bool]. *)

val null : default:'a -> 'a t
(** Decode [null] and return [default]. *)

val option : 'a t -> 'a option t
(** Decode a value that may be [null] into an [option]. *)

val float : float t
(** Decode a [float]. *)

val int : int t
(** Decode an [int]. *)

val string : string t
(** Decode a [string]. *)

val array : 'a t -> 'a array t
(** Decode an array running a decoder on every item. *)

val dict : 'a t -> 'a Dict.t t
(** Decode a JSON object running a decoder on every value, and return it as a
    {!Dict}. *)

(** {1 Monadic operators} *)

val return : 'a -> 'a t
(** [return value] ignores the JSON value and return [value]. *)

val fail : string -> 'a t
(** [fail message] ignores the JSON value and fails with a [Failed] error. *)

val expected : string -> 'a t
(** [expected type] ignores the JSON value and fails with an [Expected] error.
*)

val map : f:('a -> 'b) -> 'a t -> 'b t
(** Create a decoder by applying [f] to the output of another decoder. Maybe you
    just want to know the length of a string:

    {[
      let string_length : int t = map ~f:String.length string
    ]} *)

val map_result :
  f:('a -> ('b, [ `Expected | `Failed ] * string) Stdlib.Result.t) ->
  'a t ->
  'b t
(** Like {!map}, but [f] may fail with an [Error] that indicates whether to fail
    with [Failed] or [Expected]. You could use it for parsing a variant type
    from a string:

    {[
      type state = Running | Stopped

      let state : state t =
        map_result string ~f:(function
            | "running" -> Ok Running
            | "stopped" -> Ok Stopped
            | state -> Error (`Expected, "state")
    ]} *)

val bind : f:('a -> 'b t) -> 'a t -> 'b t
(** Create a decoder that depends on another decoder. See {!( let* )} for
    examples. *)

(** {1 Combinators} *)

val both : 'a t -> 'b t -> ('a * 'b) t
(** Run two decoders and return their output in a tuple. Same as {!( and* )}. *)

val optional : 'a t -> 'a option t
(** Try a decoder, and if it fails return [None]. *)

val or_ : 'a t -> 'a t -> 'a t
(** Try one decoder, and if it fails try another. *)

val one_of : 'a t array -> 'a t
(** Try an array of decoder and return the first that succeeds. *)

val lazy_ : (unit -> 'a t) -> 'a t
(** Helper for parsing objects with a recursive structure:

    {[
      type family_tree = { name : string; child : recursive option }

      let family_tree =
        let rec decoder () in
          let* name = field "name"
          and* child = field "child" (option (lazy_ decoder)) in
          return { name; child }
        in
        decoder ()
    ]} *)

val field : string -> 'a t -> 'a t
(** Get a field of an object by name and run a decoder on the value. *)

val index : int -> 'a t -> 'a t
(** Get an item at a certain index in an array and run a decoder on the value.
*)

(** {1 Infix operators} *)

val ( let* ) : 'a t -> ('a -> 'b t) -> 'b t
(** A binding operator alias to {!bind}. Useful for parsing objects:

    {[
      type client = { id : int; application_name : string }
      type node = { id : int; state : string }

      type interface =
        | Client of client
        | Node of node

      let client : client t =
        let* id = field "id" int
        and* application_name =
          field "info" (field "props" (field "application.name" string))
        in
        return { id; application_name }
      in
      let node : node t =
        let* id = field "id" int
        and* state = field "info" (field "state" string) in
        return { id; state }
      in

      let interface : interface t =
        let* type_ = field "type" string in
        match type_ with
        | "PipeWire:Interface:Client" ->
            let* client = client in
            return (Client client)
        | "PipeWire:Interface:Node" ->
            let* node = node in
            return (Node node)
        | _ -> expected "interface type")
    ]} *)

val ( and* ) : 'a t -> 'b t -> ('a * 'b) t
(** A binding operator alias to {!both}, to be used with {!( let* )} when
    parsing objects:

    {[
      type pipeline_job = { id : int; pipeline_id : int; scope : string }

      let pipeline_job : pipeline_job t =
        let* id = field "id" int
        and* pipeline_id = field "pipeline_id" int
        and* scope = field "scope" string in
        return { id; pipeline_id; scope }
    ]}

    This is equivalent to using a chain of {!( let* )}, so use whichever one you
    prefer. *)

val ( <|> ) : 'a t -> 'a t -> 'a t
(** Infix alias to {!or_}.

    {[
      type gitlab_id = Id of int | Project_path of string

      let id = map int ~f:(fun id -> Id id)
      let project_path = map string ~f:(fun path -> Project_path path)
      let gitlab_id = id <|> project_path
    ]} *)
