(** Mutable mapping from strings to values.

    An abstraction over JavaScript objects. *)

type 'a t = 'a Js.dict

external empty : unit -> 'a t = ""
[@@mel.obj]
(** Creates a new empty dictionary. *)

external of_array : (string * 'a) array -> 'a t = "fromEntries"
[@@mel.scope "Object"]
(** Returns a new dict from an array of (key, value) pairs. *)

external of_iterable : (string * 'a) Iterable.t -> 'a t = "fromEntries"
[@@mel.scope "Object"]
(** Returns a new dict from an iterable of (key, value) pairs. *)

external group_iterable_by :
  'a Iterable.t -> f:(('a -> string)[@mel.uncurry]) -> 'a array t = "groupBy"
[@@mel.scope "Object"]
(** Group the items yielded by the {!Iterable.t} into a [Dict] using the key
    returned by calling [f] on each iteam of the Iterable *)

external group_iterable_byi :
  'a Iterable.t -> f:(('a -> int -> string)[@mel.uncurry]) -> 'a array t
  = "groupBy"
[@@mel.scope "Object"]
(** Like {!group_iterable_by}, but also calls the function with the index of the
    current value. *)

external get : 'a t -> key:string -> 'a option = ""
[@@mel.get_index] [@@mel.return undefined_to_opt]
(** Gets an element from the array at the given [index]. *)

external set : 'a t -> key:string -> value:'a -> 'a = ""
[@@mel.set_index]
(** Sets the item at [index] to [value]. Returns the value that was set. *)

external ( .%[] ) : 'a t -> string -> 'a option = ""
[@@mel.get_index] [@@mel.return undefined_to_opt]
(** Convenience alias to {!get}, can be used as [dict.%["a"]]. *)

external ( .%[]<- ) : 'a t -> string -> 'a -> 'a = ""
[@@mel.set_index]
(** Convenience alias to {!set}, can be used as [dict.%["a"] <- value]. *)

external entries : 'a t -> (string * 'a) array = "entries"
[@@mel.scope "Object"]
(** Returns an array containing the Dict's (key, value) pairs. *)

external keys : 'a t -> 'a array = "keys"
[@@mel.scope "Object"]
(** Returns an array containing the keys of the Dict. *)

external values : 'a t -> 'a array = "values"
[@@mel.scope "Object"]
(** Returns an array containing the values of the Dict. *)
