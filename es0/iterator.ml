(** Objects implementing the
    {{:https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols#the_iterator_protocol}
     [Iterator] protocol}. *)

type 'a t = 'a Js.iterator
(** An iterator yielding values of type ['a]. *)

external next : 'a t -> 'a Iterator_result.t = "next"
[@@mel.send]
(** Advances the iterator and returns the next value. *)

external as_iterable : 'a t -> 'a Iterable.t = "%identity"
(** Cast an [Iterator] to {!Iterable.t}.

    [Iterator]s generally provide the [Iterable] interface, so this is a helper
    function to convert between the two for functions that expect an [Iterable].
*)
