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

let rec of_value : value -> unknown = function
  | Null -> Reflect.cast Es0.Null.empty
  | Boolean bool -> Reflect.cast bool
  | Number num -> Reflect.cast num
  | String string -> Reflect.cast string
  | Array arr -> Reflect.cast arr
  | Object dict -> Reflect.cast dict

let parse str = Exn.wrap Es0.Json.parse str
let parse_value str = parse str |> to_value
let stringify ?space v = Es0.Json.stringify ?replacer:None ?space v
