(** Generic opaque byte arrays. *)

type t = Js.arrayBuffer
(** The JavaScript [ArrayBuffer] type. Represents a generic byte array that
    cannot be indexed. *)

type options
(** Options for the [make] constructor. *)

external options : ?maxByteLength:int -> options = "" [@@mel.obj]

external make : length:int -> ?options:options -> t = "ArrayBuffer"
[@@mel.new]
(** Create a ArrayBuffer with a size in bytes.

    If [max_byte_length] is provided, the ArrayBuffer is {!resizable} up to
    [max_byte_length] bytes. *)

external is_view : 'a -> bool = "isView"
[@@mel.scope "ArrayBuffer"]
(** Returns [true] if the object is one of the ArrayBuffer views. *)

external byte_length : t -> int = "byteLength"
[@@mel.get]
(** The size of the ArrayBuffer in bytes. *)

external max_byte_length : t -> int = "maxByteLength"
[@@mel.get]
(** The maximum length in bytes that the ArrayBuffer can be resized to. *)

external resizable : t -> bool = "resizable"
[@@mel.get]
(** Returns [true] if the ArrayBuffer can be resized. *)

external detached : t -> bool = "detached"
[@@mel.get]
(** [true] if the ArrayBuffer has been
    {{:https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer#transferring_arraybuffers}
     transferred} and is no longer valid. *)

external resize : length:int -> (t[@mel.this]) -> unit = "resize"
[@@mel.send]
(** Resize the ArrayBuffer to the new [length].

    Raises a [TypeError] if the ArrayBuffer is detached or not resizable.

    Raises a [RangeError] if [length] is larger than the [max_byte_length] of
    the ArrayBuffer. *)

external slice : start:int -> ?end_:int -> (t[@mel.this]) -> t = "slice"
[@@mel.send]
(** Create a new ArrayBuffer whose contents are a copy of the original
    ArrayBuffer's bytes from [start] (inclusive) up to [end_] (exclusive). If
    either [start] or [end] is negative, it refers to an index from the end of
    the array, as opposed to the beginning.

    The returned ArrayBuffer is not {!resizable}. *)

external transfer : ?length:int -> (t[@mel.this]) -> t = "transfer"
[@@mel.send]
(** Create a new ArrayBuffer with the same byte content as the original
    ArrayBuffer, then {{!detached} detaches} the original. The new ArrayBuffer
    is {!resizable} if the original ArrayBuffer is also {!resizable}.

    [length] defaults to the {!byte_length} of the original ArrayBuffer. If it
    is smaller than the original {!byte_length}, the overflowing bytes are
    dropped. If it is larger, the extra bytes are filled with [0]. If the
    original ArrayBuffer is {!resizable}, [length] must not be greater than the
    original's {!max_byte_length}. *)

external transfer_to_fixed_length : ?length:int -> (t[@mel.this]) -> t
  = "transferToFixedLength"
[@@mel.send]
(** Same as {!transfer}, but the newly created ArrayBuffer is not {!resizable}
    even if the original is. *)
