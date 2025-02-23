(** Objects that can be indexed like arrays. *)

type 'a t
(** An
    {{:https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array#array-like_objects}
     array-like object} which has a [length] property and has indexed elements
    in the range [0 .. length-1]. *)

external length : _ t -> int = "length"
[@@mel.get]
(** Returns the number of elements in the array-like object. *)

external get : 'a t -> int -> 'a option = ""
[@@mel.get_index] [@@mel.return undefined_to_opt]
(** Gets the element at the given [index] of the array. *)
