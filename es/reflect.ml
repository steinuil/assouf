open Pervasives

include Es0.Reflect
(** @inline *)

let[@inline] is_null v = cast v == Es0.Null.empty
let[@inline] is_undefined v = cast v == Es0.Undefined.empty
