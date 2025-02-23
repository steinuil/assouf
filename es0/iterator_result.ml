(** The object returned by the [next] function of an [Iterator]. *)

type 'a t
(** The value returned by {!Iterator.next}, functionally equivalent to
    ['a option]. *)

external done_ : _ t -> bool option = "done"
[@@mel.get] [@@mel.return undefined_to_opt]
(** A value that's [Some false] or [None] if the iterator was able to produce
    the next value in the sequence.

    Has the value [Some true] if the iterator has completed its sequence. *)

external value : 'a t -> 'a Undefined.t = "value"
[@@mel.get]
(** Any value returned by the iterator. *)
