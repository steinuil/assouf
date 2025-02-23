(** Values guaranteed to be unique. *)

type t
(** A JavaScript [Symbol], representing an object that's guaranteed to be
    unique. *)

external make : ?description:string -> unit -> t = "Symbol"
(** Create a [Symbol] with an optional description. *)

external description : t -> string option = "description"
[@@mel.get] [@@mel.return undefined_to_opt]
(** Get the description of a [Symbol]. *)

(** {1 Well-known symbols} *)

external species : t = "species"
[@@mel.scope "Symbol"]
(** A constructor function that is used to create derived objects. *)

external to_string_tag : t = "toStringTag"
[@@mel.scope "Symbol"]
(** A string value used for the default description of an object. *)

external has_instance : t = "hasInstance"
[@@mel.scope "Symbol"]
(** A method determining if a constructor object recognizes an object as its
    instance. Used by [instanceof]. *)

external to_primitive : t = "toPrimitive"
[@@mel.scope "Symbol"]
(** A method converting an object to a primitive value. *)

external unscopables : t = "unscopables"
[@@mel.scope "Symbol"]
(** An object value of whose own and inherited property names are excluded from
    the [with] environment bindings of the associated object. *)

external iterator : t = "iterator"
[@@mel.scope "Symbol"]
(** Set on methods that implement the Iterable protocol. *)

external async_iterator : t = "asyncIterator"
[@@mel.scope "Symbol"]
(** Set on methods that implement the AsyncIterable protocol. *)

external is_concat_spreadable : t = "isConcatSpreadable"
[@@mel.scope "Symbol"]
(** A Boolean value indicating if an object should be flattened to its array
    elements. *)

external match_ : t = "match"
[@@mel.scope "Symbol"]
(** A method that matches against a string, also used to determine if an object
    may be used as a regular expression. *)

external match_all : t = "matchAll"
[@@mel.scope "Symbol"]
(** A method that returns an iterator which yields matches of the regular
    expression against a string. *)

external replace : t = "replace"
[@@mel.scope "Symbol"]
(** A method that replaces matched substrings of a string. *)

external search : t = "search"
[@@mel.scope "Symbol"]
(** A method that returns the index within a string that matches the regular
    expression. *)

external split : t = "split"
[@@mel.scope "Symbol"]
(** A method that splits a string at the indices that match a regular
    expression. *)

(** {1 Interacting with the global Symbol registry} *)

external for_ : string -> t = "for"
[@@mel.scope "Symbol"]
(** Searches for existing registered symbols in the global Symbol registry with
    the given key and returns it if found. Otherwise a new Symbol gets created
    and registered with key. *)

external key_for : t -> string option = "keyFor"
[@@mel.scope "Symbol"] [@@mel.return undefined_to_opt]
(** Retrieves a shared Symbol key from the global Symbol registry for the given
    Symbol. *)
