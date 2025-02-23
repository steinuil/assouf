(** Proxies for value that will be eventually resolved. *)

type 'a t = 'a Js.promise
(** A JavaScript [Promise] object. *)

external make :
  ((resolve:(('a -> unit)[@u]) -> reject:((_ -> unit)[@u]) -> _)[@mel.uncurry]) ->
  'a t = "Promise"
[@@mel.new]
(** Create a Promise that will be resolved or rejected when its [resolve] or
    [reject] parameters are called. *)

(* TODO external with_resolvers : unit -> *)

external resolve : 'a -> 'a t = "resolve"
[@@mel.scope "Promise"]
(** Create a Promise that resolves to the specified value. *)

external reject : _ -> 'a t = "reject"
[@@mel.scope "Promise"]
(** Create a Promise that rejects to the specified value. *)

external then_ :
  f:('a -> 'b t) -> ?catch:('err -> 'b t) -> ('a t[@mel.this]) -> 'b t = "then"
[@@mel.send]
(** Returns a Promise which will resolve to the value resolved by the Promise
    returned by calling respectively [f] or [catch] on the resolved or rejected
    value of the callling Promise. *)

external then_map :
  f:('a -> 'b) -> ?catch:('err -> 'b) -> ('a t[@mel.this]) -> 'b t = "then"
[@@mel.send]
(** Returns a Promise which will resolve to the value returned by calling
    respectively [f] or [catch] on the resolved or rejected value of the
    callling Promise. *)

external catch : f:('err -> 'b t) -> ('a t[@mel.this]) -> 'b t = "catch"
[@@mel.send]
(** Returns a Promise that, if the calling Promise is rejected, resolves to the
    value of the Promise returned by calling [f] on the rejected value of the
    calling Promise. *)

external catch_map : f:('err -> 'b) -> ('a t[@mel.this]) -> 'b t = "catch"
[@@mel.send]
(** Returns a Promise that, if the calling Promise is rejected, resolves to the
    value returned by calling [f] on the rejected value of the calling Promise.
*)

external flatten : 'a t t -> 'a t = "%identity"
(** Flatten two nested promises into a promise that resolves or rejects to the
    value of the inner Promise.

    Promises don't actually nest in JS, so this is implemented as the identity
    function. *)

external finally : f:(unit -> _) -> ('a t[@mel.this]) -> 'a t = "finally"
[@@mel.send]
(** Returns a promise that resolves or rejects to the same value of the calling
    Promise, but also calls [f] when the Promise becomes settled. *)

external all : 'a t array -> 'a array t = "all"
[@@mel.scope "Promise"]
(** Takes an array of Promises as input and returns a single Promise that
    resolves to an array containing the resolved values of the Promises if all
    of the Promises resolve. If one of the Promises rejects, it rejects with
    that Promise's rejection value. *)

external all2 : 'a t * 'b t -> ('a * 'b) t = "all"
[@@mel.scope "Promise"]
(** Like {!all}, but takes a heterogeneous tuple of promises. *)

external all_settled : 'a t array -> 'a Promise_outcome.t array t = "allSettled"
[@@mel.scope "Promise"]
(** Takes an array of Promises as input. Returns a single Promise that resolves
    when all of the input Promises are either resolved or rejected, and contains
    an array of {!Promise_outcome.t} containing the status of each Promise in
    the input. *)

external any : 'a t array -> 'a t = "any"
[@@mel.scope "Promise"]
(** Takes an array of Promises as input, and returns a single Promise that
    resolves to the value of the first Promise that resolves, and rejects to an
    [AggregateError] if all of the input Promises are rejected. *)

external race : 'a t array -> 'a t = "race"
[@@mel.scope "Promise"]
(** Takes an array of Promises as input, and returns a single Promise that
    resolves to the first resolved or rejected value of the first promise that
    settles. *)

external try_ : (unit -> 'a t) -> 'a t = "try"
[@@mel.scope "Promise"]
(** Wraps the result of a function in a Promise. The Promise is rejected if the
    function returns a rejected Promise, and is resolved if the function returns
    a resolved Promise. *)

external try_map : (unit -> 'a) -> 'a t = "try"
[@@mel.scope "Promise"]
(** Wraps the result of a function in a Promise. The Promise is rejected if the
    function throws an error, and is resolved if the function returns a value.
*)
