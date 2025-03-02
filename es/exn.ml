(** Exceptions. *)

module Js = struct
  include Es0.Error
  (** @inline *)

  exception Error = Caml_js_exceptions.Error
  (** An exception raised by JavaScript code. *)
end

open Pervasives
open Es0

exception Error of string
(** The base JavaScript Error. *)

exception Eval of string
(** An error thrown by the [eval] function. *)

exception Range of string
(** An error that occurs when a numeric variable or parameter is outside its
    valid range. *)

exception Reference of string
(** An error that occurs when accessing a variable that doesn't exist in the
    current scope. *)

exception Syntax of string
(** A syntax error in JavaScript code or a parsing error in [JSON.parse]. *)

exception Type of string
(** An error generally thrown when a variable passed to a function is not of the
    expected type. *)

exception Uri of string
(** Error thrown by the URI encoding and decoding functions. *)

exception Aggregate of string * exn array
(** Error returned by [Promise.any] when all promises passed to it reject. *)

exception Unknown of Js.t
(** A non-standard JavaScript error. *)

(** Turn a JS error into an OCaml exception. *)
let rec of_error (e : Js.t) =
  let message = Error.message e in
  match Error.name e with
  | "Error" -> Error message
  | "EvalError" -> Eval message
  | "RangeError" -> Range message
  | "ReferenceError" -> Reference message
  | "SyntaxError" -> Syntax message
  | "TypeError" -> Type message
  | "URIError" -> Uri message
  | "AggregateError" ->
      let errors = Error.errors e |> Array.map ~f:of_error in
      Aggregate (message, errors)
  | _ -> Unknown e

(** Wrap a function that may raise a JS exception and transform any JS
    exceptions it raises into native OCaml exceptions. *)
let wrap fn arg =
  try fn arg with Caml_js_exceptions.Error e -> raise (of_error e)
