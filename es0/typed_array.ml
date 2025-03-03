type 'a t

external buffer : _ t -> Array_buffer.t = "buffer" [@@mel.get]
external byte_length : _ t -> int = "byteLength" [@@mel.get]
external byte_offset : _ t -> int = "byteOffset" [@@mel.get]
external length : _ t -> int = "length" [@@mel.get]
external bytes_per_element : _ t -> int = "BYTES_PER_ELEMENT" [@@mel.get]

external get : 'a t -> int -> 'a option = ""
[@@mel.get_index] [@@mel.return undefined_to_opt]

external set : 'a t -> int -> 'a -> unit = "" [@@mel.set_index]

external at : index:int -> ('a t[@mel.this]) -> 'a option = "at"
[@@mel.send] [@@mel.return undefined_to_opt]

external copy_within :
  target:'a t -> start:int -> ?end_:int -> ('a t[@mel.this]) -> 'a t
  = "copyWithin"
[@@mel.send]
