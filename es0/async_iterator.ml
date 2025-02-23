(** Objects implementing the
    {{:https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols#the_async_iterator_and_async_iterable_protocols}
     [AsyncIterator] protocol}. *)

type 'a t
(** An iterator yielding {!Promise}s to values of type ['a]. *)

external next : 'a t -> 'a Iterator_result.t Promise.t = "next"
[@@mel.send]
(** Advances the iterator and returns a promise to the next value. *)

external as_iterable : 'a t -> 'a Async_iterable.t = "%identity"
(** Cast an [Async_iterator] to {!Async_iterable.t}.

    [AsyncIterator]s generally provide the [AsyncIterable] interface, so this is
    a helper function to convert between the two for functions that expect an
    [Async_iterable]. *)
