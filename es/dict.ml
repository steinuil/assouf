include Es0.Dict
(** @inline *)

open Pervasives

let fold_ok ~f ~init dict =
  entries dict
  |> Array.fold_ok ~init ~f:(fun acc (key, value) -> f acc key value)

let map_ok ~f dict =
  fold_ok dict ~init:(empty ()) ~f:(fun out key value ->
      match f key value with
      | Ok value ->
          set out ~key ~value |> ignore;
          Ok out
      | Error e -> Error e)
