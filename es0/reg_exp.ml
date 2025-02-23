(** Regular expressions. *)

type t = Js.re
(** A JavaScript [RegExp] object. *)

external make : string -> flags:string -> t = "RegExp"
[@@mel.new]
(** Creates a new [Reg_exp] object. *)

external escape : string -> string = "escape"
[@@mel.scope "RegExp"]
(** Escapes any potential regex syntax characters in a string, and returns a new
    string that can be safely used as a literal pattern for the [make]
    constructor. *)

external source : t -> string = "source"
[@@mel.get]
(** The text of the pattern. *)

external flags : t -> string = "flags"
[@@mel.get]
(** A string that contains the flags of the [Reg_exp] object. *)

external dot_all : t -> bool = "dotAll"
[@@mel.get]
(** Whether [.] matches newlines or not. *)

external global : t -> bool = "global"
[@@mel.get]
(** Whether to test the regular expression against all possible matches in a
    string, or only against the first. *)

external has_indices : t -> bool = "hasIndices"
[@@mel.get]
(** Whether the regular expression result exposes the start and end indices of
    captured substrings. *)

external ignore_case : t -> bool = "ignoreCase"
[@@mel.get]
(** Whether to ignore case while attempting a match in a string. *)

external multiline : t -> bool = "multiline"
[@@mel.get]
(** Whether or not to search in strings across multiple lines. *)

external sticky : t -> bool = "sticky"
[@@mel.get]
(** Whether or not the search is sticky. *)

external unicode : t -> bool = "unicode"
[@@mel.get]
(** Whether or not Unicode features are enabled. *)

external unicode_sets : t -> bool = "unicodeSets"
[@@mel.get]
(** Whether or not the v flag, an upgrade to the u mode, is enabled. *)

external exec : string -> pattern:(t[@mel.this]) -> Reg_exp_match.t option
  = "exec"
[@@mel.send] [@@mel.return null_to_opt]
(** Executes a search for a match in its string parameter. *)

external test : string -> pattern:(t[@mel.this]) -> bool = "test"
[@@mel.send]
(** Tests for a match in its string parameter. *)

external to_string : t -> string = "toString" [@@mel.send]
