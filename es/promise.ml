include Es0.Promise
(** @inline *)

open Es0

(* type 'a t = 'a Promise.t *)

(** {1 Constructors} *)

(* let resolve = Promise.resolve *)
(* let reject = Promise.reject *)

(** {1 Callbacks} *)

let[@inline] bind = Promise.then_
let[@inline] map = Promise.then_map

(* let bind p ~f = Promise.then_ ~f p *)
(* let catch p ~f = Promise.catch ~f p *)
(* let map p ~f = Promise.then_map ~f p *)
(* let map_err p ~f = Promise.catch_map ~f p *)
(* let fold p ~resolve ~reject = Promise.then_ ~f:resolve ~catch:reject *)
(* let join = Promise.flatten *)
(* let finally p ~(f : unit -> unit) = Promise.finally ~f p *)
(* let both p1 p2 = Promise.all2 (p1, p2) *)

(** {1 Concurrency} *)

let all = Promise.all
let any = Promise.any

module Syntax = struct
  external ( let* ) : ('a t[@mel.this]) -> ('a -> 'b t) -> 'b t = "then"
  [@@mel.send]

  let[@inline] ( and* ) p1 p2 = Promise.all2 (p1, p2)
end
