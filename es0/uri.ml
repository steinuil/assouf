(** Functions to encode and decode Universal Resource Identifiers (URIs). *)

external encode : string -> string = "encodeURI"
(** Encode a URI by replacing each instance of certain characters by one, two,
    three or four escape sequences representing the UTF-8 encoding of the
    character. *)

external encode_component : string -> string = "encodeURIComponent"
(** Encode a URI by replacing each instance of certain characters by one, two,
    three or four escape sequences representing the UTF-8 encoding of the
    character. Compared to {!encode}, this function also encodes characters that
    are part of the URI syntax. *)

external decode : string -> string = "decodeURI"
(** Decode a URI previously created by {!encode} or a similar function. *)

external decode_component : string -> string = "decodeURIComponent"
(** Decode a URI component previously created by {!encode_component} or by a
    similar function. *)
