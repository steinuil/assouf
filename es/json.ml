open Pervasives

module Unknown = struct
  type t

  let parse str = Exn.wrap Es0.Json.parse str
  let stringify ?space v = Es0.Json.stringify ?replacer:None ?space v
end

type t =
  | Null
  | Boolean of bool
  | Number of float
  | String of string
  | Array of t array
  | Object of t Dict.t

let rec of_unknown (json : Unknown.t) =
  match Reflect.typeof json with
  | `string -> String (Reflect.cast json)
  | `number -> Number (Reflect.cast json)
  | `boolean -> Boolean (Reflect.cast json)
  | `\#object when Reflect.is_null json -> Null
  | `\#object when Reflect.is_array json ->
      let values = Array.map ~f:of_unknown (Reflect.cast json) in
      Array values
  | `\#object ->
      let values =
        Dict.entries (Reflect.cast json)
        |> Array.map ~f:(fun (k, v) -> (k, of_unknown v))
        |> Dict.of_array
      in
      Object values
  | (`bigint | `\#function | `symbol | `undefined) as t ->
      raise (Exn.Type ("invalid JSON type: " ^ Reflect.cast t))

let to_unknown : t -> Unknown.t = function
  | Null -> Reflect.cast Es0.Null.empty
  | Boolean bool -> Reflect.cast bool
  | Number num -> Reflect.cast num
  | String string -> Reflect.cast string
  | Array arr -> Reflect.cast arr
  | Object dict -> Reflect.cast dict

let of_string str = Unknown.parse str |> of_unknown
let to_string ?space v = Unknown.stringify ?space (to_unknown v)
