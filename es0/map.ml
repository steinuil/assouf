(** Mutable mapping from keys of arbitrary type to values. *)

type ('key, 'value) t = ('key, 'value) Js.Map.t
(** A JavaScript [Set] object, representing a mapping from key to value that may
    contain keys of any type. *)

external empty : unit -> ('k, 'v) t = "Map"
[@@mel.new]
(** Creates an empty [Map]. *)

external of_iterable : ('k * 'v) Iterable.t -> ('k, 'v) t = "Map"
[@@mel.new]
(** Create a new [Map] from the values in the {!Iterable.t}. *)

external group_iterable_by : 'v Iterable.t -> f:('v -> 'k) -> ('k, 'v array) t
  = "groupBy"
[@@mel.scope "Map"]
(** Group the values yielded by the {!Iterable.t} into a [Map] using the key
    returned by calling [f] on each item of the Iterable. *)

external group_iterable_byi : 'v Iterable.t -> f:('v -> int -> 'k) -> ('k, 'v) t
  = "groupBy"
[@@mel.scope "Map"]
(** Like {!group_iterable_by}, but also calls the function with the index of the
    current value. *)

external size : _ t -> int = "size"
[@@mel.get]
(** Returns the number of key/value pairs in the [Map]. *)

external get : ('k, 'v) t -> key:'k -> 'v option = "get"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Returns the value associated to the passed key, or [None] if there is none.
*)

external set : ('k, 'v) t -> key:'k -> value:'v -> ('k, 'v) t = "set"
[@@mel.send]
(** Adds or updates an entry in this [Map] with a specified [key] and a [value].
    Returns the [Map] object. *)

external ( .%{} ) : ('k, 'v) t -> 'k -> 'v option = "get"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Convenience alias to {!get}. *)

external ( .%{}<- ) : ('k, 'v) t -> 'k -> 'v -> ('k, 'v) t = "set"
[@@mel.send]
(** Convenience alias to {!set}. *)

external has : ('k, _) t -> key:'k -> bool = "has"
[@@mel.send]
(** Returns a boolean indicating whether a value has been associated with the
    [key] in the [Map] or not. *)

external delete : ('k, _) t -> key:'k -> bool = "delete"
[@@mel.send]
(** Removes the entry with the specified [key] from the [Map] and returns [true]
    if the element existsted in the [Map], or [false] otherwise. *)

external for_each : ('k, 'v) t -> f:('v -> 'k -> _) -> unit = "forEach"
[@@mel.send]
(** Calls [f] once for each key-value pair present in the [Map] object, in
    insertion order. *)

external clear : _ t -> unit = "clear"
[@@mel.send]
(** Removes all key-value pairs from the [Map] *)

(** {1 Iterators} *)

external entries : ('k, 'v) t -> ('k * 'v) Iterator.t = "entries"
[@@mel.send]
(** Returns an {!Iterator.t} over the key-value pairs of the [Map]. *)

external keys : ('k, _) t -> 'k Iterator.t = "keys"
[@@mel.send]
(** Returns an {!Iterator.t} over the keys of the [Map]. *)

external values : (_, 'v) t -> 'v Iterator.t = "values"
[@@mel.send]
(** Returns an {!Iterator.t} over the values of the [Map]. *)

external as_iterable : ('k, 'v) t -> ('k * 'v) Iterable.t = "%identity"
(** Cast to an {!Iterable.t} over the key-value pairs of the [Map]. *)
