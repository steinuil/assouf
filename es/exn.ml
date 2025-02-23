open Stdlib
open Es0

include Error
(** @inline *)

exception Js_error = Caml_js_exceptions.Error
(** An exception raised by JavaScript code. *)

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

exception Unknown of t
(** A non-standard JavaScript error. *)

(** Turn a JS error into an OCaml exception. *)
let rec of_error e =
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

(** Wrap exception raised by a JS function into OCaml exceptions. *)
let wrap fn arg =
  try fn arg with Caml_js_exceptions.Error e -> raise (of_error e)
