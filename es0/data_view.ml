(** Views that allow to operate on {!Array_buffer.t} or
    {!Shared_array_buffer.t}. *)

type t
(** The JavaScript [DataView] object. *)

external of_array_buffer : Array_buffer.t -> ?offset:int -> ?length:int -> t
  = "DataView"
[@@mel.new]
(** Create a [DataView] from an {!Array_buffer.t} starting from the specified
    byte [offset] and ending at [offset + length]. *)

external of_shared_array_buffer :
  Shared_array_buffer.t -> ?offset:int -> ?length:int -> t = "DataView"
[@@mel.new]

external buffer : t -> Array_buffer.t = "buffer"
[@@mel.get]
(** The {!Array_buffer.t} referenced by this [DataView]. *)

external byte_length : t -> int = "byteLength"
[@@mel.get]
(** The byte length of this view. *)

external byte_offset : t -> int = "byteOffset"
[@@mel.get]
(** The byte offset of this view. *)

(** {1 Reading data} *)

external get_int8 : offset:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "getInt8"
[@@mel.send]
(** Read an 8-bit signed integer from the byte at [offset] *)

external get_uint8 : offset:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "getUint8"
[@@mel.send]
(** Read an 8-bit unsigned integer from the byte at [offset] *)

external get_int16 : offset:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "getInt16"
[@@mel.send]
(** Read a 16-bit signed integer from the 2 bytes starting at [offset]. *)

external get_uint16 : offset:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "getUint16"
[@@mel.send]
(** Read a 16-bit unsigned integer from the 2 bytes starting at [offset]. *)

external get_int32 : offset:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "getInt32"
[@@mel.send]
(** Read a 32-bit signed integer from the 4 bytes starting at [offset]. *)

external get_uint32 : offset:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "getUint32"
[@@mel.send]
(** Read a 32-bit unsigned integer from the 4 bytes starting at [offset]. *)

external get_big_int64 :
  offset:int -> ?little_endian:bool -> (t[@mel.this]) -> Big_int.t
  = "getBigInt64"
[@@mel.send]
(** Read a signed 64-bit integer from the 8 bytes starting at [offset]. *)

external get_big_uint64 :
  offset:int -> ?little_endian:bool -> (t[@mel.this]) -> Big_int.t
  = "getBigUint64"
[@@mel.send]
(** Read an unsigned 64-bit integer from the 8 bytes starting at [offset]. *)

external get_float16 : offset:int -> ?little_endian:bool -> float = "getFloat16"
[@@mel.send]
(** Read a 16-bit float from the 2 bytes starting at [offset]. *)

external get_float32 : offset:int -> ?little_endian:bool -> float = "getFloat32"
(** Read a 32-bit float from the 4 bytes starting at [offset]. *)

external get_float64 : offset:int -> ?little_endian:bool -> float = "getFloat64"
(** Read a 64-bit float from the 8 bytes starting at [offset]. *)

(** {1 Modifying data} *)

external set_int8 :
  offset:int -> value:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "setInt8"
[@@mel.send]
(** Set [offset] to [value] truncated to an 8-bit signed integer. *)

external set_uint8 :
  offset:int -> value:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "setUint8"
[@@mel.send]
(** Set [offset] to [value] truncated to an 8-bit unsigned integer. *)

external set_int16 :
  offset:int -> value:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "setInt16"
[@@mel.send]
(** Set the 2 bytes starting at [offset] to [value] truncated to a 16-bit signed
    integer. *)

external set_uint16 :
  offset:int -> value:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "setUint16"
[@@mel.send]
(** Set the 2 bytes starting at [offset] to [value] truncated to a 16-bit
    unsigned integer. *)

external set_int32 :
  offset:int -> value:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "setInt32"
[@@mel.send]
(** Set the 4 bytes starting at [offset] to [value] truncated to a 32-bit signed
    integer. *)

external set_uint32 :
  offset:int -> value:int -> ?little_endian:bool -> (t[@mel.this]) -> int
  = "setUint32"
[@@mel.send]
(** Set the 4 bytes starting at [offset] to [value] truncated to a 32-bit
    unsigned integer. *)

external set_big_int64 :
  offset:int ->
  value:Big_int.t ->
  ?little_endian:bool ->
  (t[@mel.this]) ->
  Big_int.t = "setBigInt64"
[@@mel.send]
(** Set the 8 bytes starting at [offset] to [value] truncated to a 64-bit signed
    integer. *)

external set_big_uint64 :
  offset:int ->
  value:Big_int.t ->
  ?little_endian:bool ->
  (t[@mel.this]) ->
  Big_int.t = "setBigUint64"
[@@mel.send]
(** Set the 8 bytes starting at [offset] to [value] truncated to a 64-bit
    unsigned integer. *)

external set_float16 : offset:int -> value:float -> ?little_endian:bool -> float
  = "setFloat16"
[@@mel.send]
(** Set the 2 bytes starting at [offset] to [value] converted to a 16-bit float.
*)

external set_float32 : offset:int -> value:float -> ?little_endian:bool -> float
  = "setFloat32"
(** Set the 4 bytes starting at [offset] to [value] converted to a 32-bit float.
*)

external set_float64 : offset:int -> value:float -> ?little_endian:bool -> float
  = "setFloat64"
(** Set the 8 bytes starting at [offset] to [value]. *)
