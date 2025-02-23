(** The return value of {!Promise.all_settled} representing the fulfillment
    status of a Promise. *)

type 'a t
(** An object representing the fulfillment status of a Promise. *)

external status : _ t -> [ `fulfilled | `rejected ] = "status"
[@@mel.get]
(** Indicates the eventual state of the Promise. *)

external value : 'a t -> 'a option = "value"
[@@mel.get] [@@mel.return undefined_to_opt]
(** The resolved value of the Promise. Only present if the Promise is fulfilled.
*)

external reason : _ t -> 'err option = "reason"
[@@mel.get] [@@mel.return undefined_to_opt]
(** The rejected value of the Promise. Only present if the Promise is rejected.
*)
