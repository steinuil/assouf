open Pervasives

type unknown

type value =
  | Null
  | Boolean of bool
  | Number of float
  | String of string
  | Array of value array
  | Object of value Dict.t

let rec to_value (json : unknown) =
  match Reflect.typeof json with
  | `string -> String (Reflect.cast json)
  | `number -> Number (Reflect.cast json)
  | `boolean -> Boolean (Reflect.cast json)
  | `\#object when Reflect.is_null json -> Null
  | `\#object when Reflect.is_array json ->
      let values = Array.map ~f:to_value (Reflect.cast json) in
      Array values
  | `\#object ->
      let values =
        Dict.entries (Reflect.cast json)
        |> Array.map ~f:(fun (k, v) -> (k, to_value v))
        |> Dict.of_array
      in
      Object values
  | `bigint | `\#function | `symbol | `undefined ->
      raise (Failure "invalid type in JSON")

let parse str = Exn.wrap Es0.Json.parse str
let parse_value str = parse str |> to_value

module Decode = struct
  type 'a error =
    | Failed of string * 'a
    | Expected of string * 'a
    | Field of string * 'a error
    | Index of int * 'a error
    | One_of of 'a error array

  let rec value_error = function
    | Field (str, err) -> Field (str, value_error err)
    | Index (index, err) -> Index (index, value_error err)
    | One_of errs -> One_of (Array.map ~f:value_error errs)
    | Expected (str, json) -> Expected (str, to_value json)
    | Failed (str, json) -> Failed (str, to_value json)

  type 'a t = unknown -> ('a, unknown error) Result.t

  let expected typ v = Error (Expected (typ, v))
  let unknown : unknown t = fun v -> Ok v
  let value : value t = fun v -> Ok (to_value v)

  let bool v =
    if Reflect.typeof v == `boolean then Ok (Reflect.cast v)
    else expected "boolean" v

  let null_with ~default v =
    if Reflect.is_null v then Ok default else expected "null" v

  let null = null_with ~default:()

  let float v =
    if Reflect.typeof v == `number then Ok (Reflect.cast v)
    else expected "float" v

  let int inp =
    match float inp with
    | Ok v when Float.is_safe_integer v -> Ok (Float.unsafe_as_int v)
    | Ok _ | Error _ -> expected "integer" inp

  let string v =
    if Reflect.typeof v == `string then Ok (Reflect.cast v)
    else expected "string" v

  let option f v =
    match null v with
    | Ok () -> Ok None
    | Error _ -> f v |> Result.map Option.some

  let return v _ = Ok v
  let fail e inp = Error (Failed (e, inp))

  let map ~f f1 inp =
    match f1 inp with Ok v1 -> Ok (f v1) | Error e -> Error e

  let bind ~f f1 inp =
    match f1 inp with Ok v1 -> f v1 inp | Error e -> Error e

  let ( let* ) inp f = bind ~f inp

  let both f1 f2 inp =
    match f1 inp with
    | Error _ as err -> err
    | Ok v1 -> (
        match f2 inp with Error _ as err -> err | Ok v2 -> Ok (v1, v2))

  let ( and* ) = both

  let or_ f1 f2 inp =
    match f1 inp with
    | Ok v -> Ok v
    | Error e -> (
        match f2 inp with
        | Ok v -> Ok v
        | Error e2 -> (
            match e with
            | One_of es -> Error (One_of (Array.append es ~other:[| e2 |]))
            | _ -> Error (One_of [| e; e2 |])))

  let ( <|> ) = or_

  let one_of fs inp =
    let errors = [||] in
    let rec loop i =
      if Array.length fs == i then Error (One_of errors)
      else
        match (Array.unsafe_get fs i) inp with
        | Ok v -> Ok v
        | Error e ->
            Array.push ~value:e errors |> ignore;
            loop (i + 1)
    in
    loop 0

  let array f inp =
    if not (Reflect.is_array inp) then Error (Expected ("array", inp))
    else
      Array.mapi_ok (Reflect.cast inp) ~f:(fun v i ->
          match f v with Ok v -> Ok v | Error e -> Error (Index (i, e)))

  let is_object v =
    Reflect.typeof v == `\#object
    && (not (Reflect.is_null v))
    && not (Reflect.is_array v)

  let dict f v =
    if not (is_object v) then Error (Expected ("object", v))
    else
      Dict.map_ok (Reflect.cast v) ~f:(fun key item ->
          match f item with
          | Ok item -> Ok item
          | Error e -> Error (Field (key, e)))

  let lazy_ f inp = f () inp

  let field key f inp =
    if not (is_object inp) then Error (Expected ("object", inp))
    else
      let v = Reflect.cast inp in
      if Es0.Object.has_own ~key v then
        let field = Es0.Object.get ~key v in
        match f field with Ok v -> Ok v | Error e -> Error (Field (key, e))
      else Error (Field (key, Failed ("field not found", inp)))

  let index i f inp =
    if not (Reflect.is_array inp) then Error (Expected ("array", inp))
    else
      let v = Reflect.cast inp in
      if Array.length v < i then
        match f (Array.unsafe_get v i) with
        | Ok v -> Ok v
        | Error e -> Error (Index (i, e))
      else Error (Index (i, Failed ("index out of bounds", inp)))

  let optional f inp =
    match f inp with Ok v -> Ok (Some v) | Error _ -> Ok None

  let parse_with ~decoder str =
    let json = parse str in
    match decoder json with
    | Ok v -> Ok v
    | Error err -> Error (value_error err)
end
