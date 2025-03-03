type t
(** The JavaScript [SharedArrayBuffer] object. *)

type options
(** Options for the [make] constructor. *)

external options : ?maxByteLength:int -> options = "" [@@mel.obj]

external make : length:int -> ?options:options -> t = "SharedArrayBuffer"
[@@mel.new]
(** Create a SharedArrayBuffer with a size in bytes.

    If [max_byte_length] is provided, the array is {!growable} up to
    [max_byte_length] bytes. *)

external byte_length : t -> int = "byteLength"
[@@mel.get]
(** The size of the SharedArrayBuffer in bytes. *)

external max_byte_length : t -> int = "maxByteLength"
[@@mel.get]
(** The maximum length in bytes that the SharedArrayBuffer can be grown to. *)

external growable : t -> bool = "growable"
[@@mel.get]
(** Returns [true] if the SharedArrayBuffer can be grown. *)

external grow : length:int -> (t[@mel.obj]) -> unit = "grow"
[@@mel.send]
(** Grow a {!growable} SharedArrayBuffer to [length]. *)

external slice : start:int -> ?end_:int -> (t[@mel.this]) -> t = "slice"
[@@mel.send]
(** Create a new SharedArrayBuffer whose contents are a copy of the original
    ArrayBuffer's bytes from [start] (inclusive) up to [end_] (exclusive). If
    either [start] or [end] is negative, it refers to an index from the end of
    the array, as opposed to the beginning. *)
