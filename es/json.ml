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
  | "string" -> String (Reflect.cast json)
  | "number" -> Number (Reflect.cast json)
  | "boolean" -> Boolean (Reflect.cast json)
  | _ when Reflect.is_null json -> Null
  | _ when Reflect.is_array json ->
      let values = Array.map ~f:to_value (Reflect.cast json) in
      Array values
  | _ ->
      let values =
        Dict.entries (Reflect.cast json)
        |> Array.map ~f:(fun (k, v) -> (k, to_value v))
        |> Dict.of_array
      in
      Object values

module Decode = struct
  type 'a error =
    | Field of string * 'a error
    | Index of int * 'a error
    | One_of of 'a error array
    | Expected of string * 'a
    | Failed of string * 'a

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

  let bool : bool t =
   fun v ->
    if Reflect.typeof v == "boolean" then Ok (Reflect.cast v)
    else expected "boolean" v

  let null_with ~default : 'a t =
   fun v -> if Reflect.is_null v then Ok default else expected "null" v

  let null : unit t = null_with ~default:()

  let float : float t =
   fun v ->
    if Reflect.typeof v == "number" then Ok (Reflect.cast v)
    else expected "float" v

  let int : int t =
   fun inp ->
    match float inp with
    | Ok v when Float.is_safe_integer v -> Ok (Float.unsafe_as_int v)
    | Ok _ | Error _ -> expected "integer" inp

  let string : string t =
   fun v ->
    if Reflect.typeof v == "string" then Ok (Reflect.cast v)
    else expected "string" v

  let option : 'a t -> 'a option t =
   fun f v ->
    match null v with
    | Ok () -> Ok None
    | Error _ -> f v |> Result.map Option.some

  let satisfies ~err ~f v = if f v then Ok v else Error err

  let map : f:('a -> 'b) -> 'a t -> 'b t =
   fun ~f f1 inp -> match f1 inp with Ok v1 -> Ok (f v1) | Error e -> Error e

  let bind : f:('a -> 'b t) -> 'a t -> 'b t =
   fun ~f f1 inp -> match f1 inp with Ok v1 -> f v1 inp | Error e -> Error e

  let ( let* ) inp f = bind ~f inp
  let ( let& ) = Result.bind
  let succeed v : 'a t = fun _ -> Ok v
  let fail e : 'a t = fun inp -> Error (Failed (e, inp))

  let or_ : 'a t -> 'a t -> 'a t =
   fun f1 f2 inp ->
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

  let one_of : 'a t array -> 'a t =
   fun fs inp ->
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

  let array : 'a t -> 'a array t =
   fun f inp ->
    let& v = satisfies ~f:Reflect.is_array inp ~err:(Expected ("array", inp)) in
    Array.mapi_ok (Reflect.cast v) ~f:(fun v i ->
        match f v with Ok v -> Ok v | Error e -> Error (Index (i, e)))

  let is_object v =
    Reflect.typeof v == "object"
    && Reflect.cast v != Es0.Null.empty
    && not (Reflect.is_array v)

  let dict : 'a t -> 'a Dict.t t =
   fun f v ->
    let& v = satisfies ~f:is_object v ~err:(Expected ("object", v)) in
    Dict.map_ok (Reflect.cast v) ~f:(fun key item ->
        match f item with
        | Ok item -> Ok item
        | Error e -> Error (Field (key, e)))

  let lazy_ : (unit -> 'a t) -> 'a t = fun f inp -> f () inp

  let field key : 'a t -> 'a t =
   fun f inp ->
    let& v = satisfies ~f:is_object inp ~err:(Expected ("object", inp)) in
    let v = Reflect.cast v in
    if Es0.Object.has_own ~key v then
      let field = Es0.Object.get ~key v in
      match f field with Ok v -> Ok v | Error e -> Error (Field (key, e))
    else Error (Field (key, Failed ("field not found", inp)))

  let index i : 'a t -> 'a t =
   fun f inp ->
    let& v = satisfies ~f:Reflect.is_array inp ~err:(Expected ("array", inp)) in
    let v = Reflect.cast v in
    if Array.length v < i then
      match f (Array.unsafe_get v i) with
      | Ok v -> Ok v
      | Error e -> Error (Index (i, e))
    else Error (Index (i, Failed ("index out of bounds", inp)))

  let optional : 'a t -> 'a option t =
   fun f inp -> match f inp with Ok v -> Ok (Some v) | Error _ -> Ok None
end

let parse str : unknown = Exn.wrap Es0.Json.parse str

let parse_with ~(decoder : 'a Decode.t) str =
  let json = parse str in
  match decoder json with
  | Ok v -> Ok v
  | Error err -> Error (Decode.value_error err)
