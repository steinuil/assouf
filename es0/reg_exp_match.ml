(** Result of a {!Reg_exp} match. *)

type t
(** The result of a regular expression match. *)

external matches : t -> string array = "%identity"
(** The array containing the matched text as first item, and then one or more
    items for each capturing group of the matching text. *)

external index : t -> int = "index"
[@@mel.get]
(** The 0-based index of the match in the string. *)

external input : t -> string = "input"
[@@mel.get]
(** The original string that was matched against. *)

external groups : t -> string Dict.t option = "groups"
[@@mel.get] [@@mel.return undefined_to_opt]
(** A dict whose keys are the names, and values are the capturing groups, or
    [None] if no named capturing groups were defined. *)
