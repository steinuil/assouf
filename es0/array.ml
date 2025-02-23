(** Array operations. *)

type 'a t = 'a array

external length : _ t -> int = "length"
[@@mel.get]
(** Reflects the number of elements in an array. *)

(** {1 Indexing} *)

external get : 'a t -> int -> 'a option = ""
[@@mel.get_index] [@@mel.return undefined_to_opt]
(** Gets an element from the array at the given [index]. *)

external unsafe_get : 'a t -> int -> 'a = ""
[@@mel.get_index]
(** Gets an element from the array at the given [index] without bounds checking.
*)

external set : 'a t -> int -> 'a -> unit = ""
[@@mel.set_index]
(** Sets the item at [index] to [value]. *)

external at : index:int -> ('a t[@mel.this]) -> 'a option = "at"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Returns the array item at the given [index]. Accepts negative integers,
    which count back from the last item. *)

external slice : start:int -> ?end_:int -> ('a t[@mel.this]) -> 'a t = "slice"
[@@mel.send]
(** Extracts a section of the calling array and returns a new array. *)

(** {1 Creating arrays} *)

external copy : 'a t -> 'a t = "slice"
[@@mel.send]
(** Create a shallow copy of the array. *)

external make : length:int -> 'a t = "Array"
(** Create a empty array with [length] empty slots. *)

external of_iterable : 'a Iterable.t -> 'a t = "from"
[@@mel.scope "Array"]
(** Create a new array from an {!Iterable.t}. *)

external of_iterable_map : 'a Iterable.t -> f:('a -> 'b) -> 'b t = "from"
[@@mel.scope "Array"]
(** Create a new array by callling [f] on each value returned from an
    {!Iterable.t}. *)

external of_iterable_mapi : 'a Iterable.t -> f:('a -> int -> 'b) -> 'b t
  = "from"
[@@mel.scope "Array"]
(** Create a new array by callling [f] on each value returned from an
    {!Iterable.t}. *)

external of_array_like : 'a Array_like.t -> 'a t = "from"
[@@mel.scope "Array"]
(** Create a new array from an {!Array_like.t}. *)

external of_array_like_map : 'a Array_like.t -> f:('a -> int -> 'b) -> 'b t
  = "from"
[@@mel.scope "Array"]
(** Create a new array by callling [f] on each value returned from an
    {!Array_like.t}. *)

external of_async_iterable : 'a Async_iterable.t -> 'a t Promise.t = "fromAsync"
[@@mel.scope "Array"]
(** Create a new array from an {!Async_iterable.t}. *)

external of_async_iterable_map :
  'a Async_iterable.t -> f:('a -> int -> 'b Promise.t) -> 'b t Promise.t
  = "fromAsync"
[@@mel.scope "Array"]
(** Create a new array by calling [f] on each value returned from an
    {!Async_iterable.t}. *)

(** {1 Searching} *)

external includes : value:'a -> ?start:int -> ('a t[@mel.this]) -> bool
  = "includes"
[@@mel.send]
(** Determines whether the calling array contains a value, returning [true] or
    [false] as appropriate. *)

external find : f:('a -> int -> bool) -> ('a t[@mel.this]) -> 'a option = "find"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Returns the value of the first element in the array that satisfies the
    provided testing function, or [None] if no appropriate element is found. *)

external find_last : f:('a -> int -> bool) -> ('a t[@mel.this]) -> 'a option
  = "findLast"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Returns the value of the last element in the array that satisfies the
    provided testing function, or [None] if no appropriate element is found. *)

external index_of : value:'a -> ?start:int -> ('a t[@mel.this]) -> int
  = "indexOf"
[@@mel.send]
(** Returns the first (least) index at which a given element can be found in the
    calling array. *)

external last_index_of : value:'a -> ?start:int -> ('a t[@mel.this]) -> int
  = "lastIndexOf"
[@@mel.send]
(** Returns the last (greatest) index at which a given element can be found in
    the calling array, or [-1] if none is found. *)

external find_index : f:('a -> int -> bool) -> ('a t[@mel.this]) -> int
  = "findIndex"
[@@mel.send]
(** Returns the index of the first element in the array that satisfies the
    provided testing function, or [-1] if no appropriate element was found. *)

external find_last_index : f:('a -> int -> bool) -> ('a t[@mel.this]) -> int
  = "findLastIndex"
[@@mel.send]
(** Returns the index of the last element in the array that satisfies the
    provided testing function, or [-1] if no appropriate element was found. *)

(** {1 Functional updates} *)

external map : f:(('a -> 'b)[@mel.uncurry]) -> ('a t[@mel.this]) -> 'b t = "map"
[@@mel.send]
(** Returns a new array containing the results of invoking a function on every
    element in the calling array. *)

external mapi : f:(('a -> int -> 'b)[@mel.uncurry]) -> ('a t[@mel.this]) -> 'b t
  = "map"
[@@mel.send]
(** Returns a new array containing the results of invoking a function on every
    element in the calling array. *)

external flat_map : f:(('a -> 'b t)[@mel.uncurry]) -> ('a t[@mel.this]) -> 'b t
  = "flatMap"
[@@mel.send]
(** Returns a new array formed by applying a given callback function to each
    element of the calling array, and then flattening the result by one level.
*)

external flat_mapi :
  f:(('a -> int -> 'b t)[@mel.uncurry]) -> ('a t[@mel.this]) -> 'b t = "flatMap"
[@@mel.send]
(** Returns a new array formed by applying a given callback function to each
    element of the calling array, and then flattening the result by one level.
*)

external filter : f:(('a -> bool)[@mel.uncurry]) -> ('a t[@mel.this]) -> 'a t
  = "filter"
[@@mel.send]
(** Returns a new array containing all elements of the calling array for which
    the provided filtering function returns [true]. *)

external filteri :
  f:(('a -> int -> bool)[@mel.uncurry]) -> ('a t[@mel.this]) -> 'a t = "filter"
[@@mel.send]
(** Returns a new array containing all elements of the calling array for which
    the provided filtering function returns [true]. *)

external reduce :
  f:(('acc -> 'a -> 'acc)[@mel.uncurry]) ->
  init:'acc ->
  ('a t[@mel.this]) ->
  'acc = "reduce"
[@@mel.send]
(** Executes a user-supplied "reducer" callback function on each element of the
    array (from left to right), to reduce it to a single value. *)

external reducei :
  f:(('acc -> 'a -> int -> 'acc)[@mel.uncurry]) ->
  init:'acc ->
  ('a t[@mel.this]) ->
  'acc = "reduce"
[@@mel.send]
(** Executes a user-supplied "reducer" callback function on each element of the
    array (from left to right), to reduce it to a single value. *)

external reduce_right :
  f:(('acc -> 'a -> 'acc)[@mel.uncurry]) ->
  init:'acc ->
  ('a t[@mel.this]) ->
  'acc = "reduceRight"
[@@mel.send]
(** Executes a user-supplied "reducer" callback function on each element of the
    array (from right to left), to reduce it to a single value. *)

external reduce_righti :
  f:(('acc -> 'a -> int -> 'acc)[@mel.uncurry]) ->
  init:'acc ->
  ('a t[@mel.this]) ->
  'acc = "reduceRight"
[@@mel.send]
(** Executes a user-supplied "reducer" callback function on each element of the
    array (from right to left), to reduce it to a single value. *)

external for_each : f:(('a -> 'b)[@mel.uncurry]) -> ('a t[@mel.this]) -> unit
  = "forEach"
[@@mel.send]
(** Calls a function for each element in the calling array. *)

external for_eachi :
  f:(('a -> int -> 'b)[@mel.uncurry]) -> ('a t[@mel.this]) -> unit = "forEach"
[@@mel.send]
(** Calls a function for each element in the calling array. *)

external every : f:(('a -> bool)[@mel.uncurry]) -> ('a t[@mel.this]) -> bool
  = "every"
[@@mel.send]
(** Returns [true] if every element in the calling array satisfies the testing
    function. *)

external everyi :
  f:(('a -> int -> bool)[@mel.uncurry]) -> ('a t[@mel.this]) -> bool = "every"
[@@mel.send]
(** Returns [true] if every element in the calling array satisfies the testing
    function. *)

external some : f:(('a -> bool)[@mel.uncurry]) -> ('a t[@mel.this]) -> bool
  = "some"
[@@mel.send]
(** Returns [true] if at least one element in the calling array satisfies the
    provided testing function. *)

external somei :
  f:(('a -> int -> bool)[@mel.uncurry]) -> ('a t[@mel.this]) -> bool = "some"
[@@mel.send]
(** Returns [true] if at least one element in the calling array satisfies the
    provided testing function. *)

external with_ : index:int -> value:'a -> ('a t[@mel.this]) -> 'a t = "with"
[@@mel.send]
(** Returns a new array with the element at the given index replaced with the
    given value, without modifying the original array. *)

external to_reversed : 'a t -> 'a t = "toReversed"
[@@mel.send]
(** Returns a new array with the elements in reversed order, without modifying
    the original array. *)

external to_sorted : f:('a -> 'a -> int) -> ('a t[@mel.this]) -> 'a t
  = "toSorted"
[@@mel.send]
(** Returns a new array with the elements sorted in ascending order, without
    modifying the original array.

    Like {!sort}, but does not modify the original array. *)

external to_spliced : start:int -> delete:int -> add_items:'a array -> 'a t
  = "toSpliced"
[@@mel.send] [@@mel.variadic]
(** Returns a new array with some elements removed and/or replaced at a given
    index, without modifying the original array.

    Like {!splice}, but does not modify the original array. *)

external append : other:'a t -> ('a t[@mel.this]) -> 'a t = "concat"
[@@mel.send]
(** Return a new array with the elements of the [other] array appended to it. *)

external concat : 'a t array -> ('a t[@mel.this]) -> 'a t = "concat"
[@@mel.send] [@@mel.variadic]
(** Returns a new array that is the calling array joined with other array(s)
    and/or value(s). *)

external flat : 'a t t -> 'a t = "flat"
[@@mel.send]
(** Returns a new array with all sub-array elements concatenated into it. *)

external join : ?sep:string -> (string t[@mel.this]) -> string = "join"
[@@mel.send]
(** Joins all elements of an array into a string. *)

external group_by : 'a t -> f:(('a -> string)[@mel.uncurry]) -> 'a t Dict.t
  = "groupBy"
[@@mel.scope "Object"]
(** Group the items in the array into a {!Dict.t} using the key returned by
    calling [f] on each item of the array. *)

external group_byi :
  'a t -> f:(('a -> int -> string)[@mel.uncurry]) -> 'a t Dict.t = "groupBy"
[@@mel.scope "Object"]
(** Group the items in the array into a {!Dict.t} using the key returned by
    calling [f] on each item of the array. *)

(** {1 Destructive updates} *)

external copy_within :
  target:'a t -> start:int -> ?end_:int -> ('a t[@mel.this]) -> 'a t
  = "copyWithin"
[@@mel.send]
(** Copies a sequence of array elements within an array. *)

external fill : value:'a -> ?start:int -> ?end_:int -> ('a t[@mel.this]) -> 'a t
  = "fill"
[@@mel.send]
(** Fills all the elements of an array from a start index to an end index with a
    static value. *)

external splice : start:int -> delete:int -> add_items:'a array -> 'a t
  = "splice"
[@@mel.send] [@@mel.variadic]
(** Adds and/or removes elements from an array. *)

external reverse : 'a t -> 'a t = "reverse"
[@@mel.send]
(** Reverses the order of the elements of an array in place. (First becomes the
    last, last becomes first.) *)

external sort : ?f:('a -> 'a -> int) -> ('a t[@mel.this]) -> 'a t = "sort"
[@@mel.send]
(** Sorts the elements of an array in place and returns the array. *)

external push : value:'a -> ('a t[@mel.this]) -> int = "push"
[@@mel.send]
(** Adds one element to the end of an array, and returns the new length of the
    array. *)

external push_many : 'a array -> ('a t[@mel.this]) -> int = "push"
[@@mel.send] [@@mel.variadic]
(** Adds one or more elements to the end of an array, and returns the new length
    of the array. *)

external unshift : value:'a -> ('a t[@mel.this]) -> int = "unshift"
[@@mel.send]
(** Adds one element to the front of the array, and returns the new length of
    the array. *)

external unshift_many : 'a array -> ('a t[@mel.this]) -> int = "unshift"
[@@mel.send]
(** Adds one or more elements to the front of an array, and returns the new
    length of the array *)

external pop : 'a t -> 'a option = "pop"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Removes the last element from an array and returns that element. *)

external shift : 'a t -> 'a option = "shift"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Removes the first element from an array and returns that element. *)

(** {1 Iterators} *)

external as_array_like : 'a t -> 'a Array_like.t = "%identity"
(** Cast to {!Array_like.t}. *)

external as_iterable : 'a t -> 'a Iterable.t = "%identity"
(** Cast to {!Iterable.t}. *)

external entries : 'a t -> (int * 'a) Iterator.t = "entries"
[@@mel.send]
(** Returns an {!Iterator.t} that contains the key/value pairs for each index in
    an array. *)

external keys : _ t -> int Iterator.t = "keys"
[@@mel.send]
(** Returns an {!Iterator.t} that contains the keys for each index in the
    calling array. *)

external values : 'a t -> 'a Iterator.t = "values"
[@@mel.send]
(** Returns an {!Iterator.t} that contains the values for each index in the
    calling array. *)
