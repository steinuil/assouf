open Pervasives

include Es0.Array
(** @inline *)

(** Short-circuiting fold over [Result]s. Returns [Ok acc] if all the folded
    values are [Ok], otherwise exits early at the first [Error]. *)
let fold_ok ~f ~init arr =
  let rec loop acc i =
    if length arr == i then Ok acc
    else
      match f acc (unsafe_get arr i) with
      | Ok acc -> loop acc (i + 1)
      | Error _ as err -> err
  in
  loop init 0

(** Like {!fold_ok}, but also passes the item's index to [f]. *)
let foldi_ok ~f ~init arr =
  let rec loop acc i =
    if length arr == i then Ok acc
    else
      match f acc (unsafe_get arr i) i with
      | Ok acc -> loop acc (i + 1)
      | Error _ as err -> err
  in
  loop init 0

let mapi_ok ~f arr =
  foldi_ok arr ~init:[||] ~f:(fun arr v i ->
      match f v i with
      | Ok value ->
          push ~value arr |> ignore;
          Ok arr
      | Error _ as err -> err)

let iterator (arr : 'a t) =
  let iterator : unit -> 'a Es0.Iterator.t =
    Reflect.cast arr |> Es0.Object.get_symbol ~key:Es0.Symbol.iterator
  in
  iterator ()
