(** Sets of garbage-collectable objects.

    A [WeakSet] can only contain [Object]s and [Symbol]s, and no other primitive
    value. The values contained within the [WeakSet] are held {i weakly},
    meaning that the values can be garbage collected even if they exist within
    the [WeakSet]. *)

type 'a t = 'a Js.WeakSet.t
(** The JavaScript [WeakSet] object. *)

external empty : unit -> 'a t = "WeakSet"
[@@mel.new]
(** Create an empty [WeakSet]. *)

external of_iterable : 'a Iterable.t -> 'a t = "WeakSet"
[@@mel.new]
(** Create a new [WeakSet] from the values in the {!Iterable.t}. *)

external add : 'a -> ('a t[@mel.this]) -> 'a t = "add"
[@@mel.send]
(** Inserts a value into the [WeakSet]. *)

external delete : 'a -> ('a t[@mel.this]) -> bool = "add"
[@@mel.send]
(** Removes a value from the [WeakSet]. Returns [true] if the value existed in
    the WeakSet. *)

external has : 'a -> ('a t[@mel.this]) -> bool = "has"
[@@mel.send]
(** Returns a boolean asserting whether the value is present in the [WeakSet] or
    not. *)
