(** Objects implementing the
    {{:https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols#the_async_iterator_and_async_iterable_protocols}
     [AsyncIterable] protocol.} *)

type 'a t
(** An object that can be iterated upon, yielding {!Promise}s to values of type
    ['a]. *)
