(** JavaScript UTF-16 strings. *)

type t = string
(** A JavaScript string encoded as a sequence of 16-bit unsigned integer values
    representing UTF-16 code units. *)

external of_char : char -> t = "%identity"
(** Casts a char to a string. *)

external of_char_code : int array -> t = "fromCharCode"
[@@mel.scope "String"] [@@mel.variadic]
(** Returns a string created by using the specified sequence of Unicode values.
*)

external of_code_point : int array -> t = "fromCodePoint"
[@@mel.scope "String"] [@@mel.variadic]
(** Returns a string created by using the specified sequence of code points. *)

external length : t -> int = "length"
[@@mel.get]
(** Reflects the [length] of the string. *)

external get : t -> int -> char option = ""
[@@mel.get_index] [@@mel.return undefined_to_opt]
(** Returns the characters at the specified index. *)

external at : index:int -> (t[@mel.this]) -> t option = "at"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Returns the character (exactly one UTF-16 code unit) at the specified
    [index]. Accepts negative integers, which count back from the last string
    character. *)

external char_at : index:int -> (t[@mel.this]) -> t option = "charAt"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Returns the character (exactly one UTF-16 code unit) at the specified
    [index]. *)

external char_code_at : index:int -> (t[@mel.this]) -> int = "charCodeAt"
[@@mel.send]
(** Returns a number that is the UTF-16 code unit value at the given [index]. *)

external code_point_at : pos:int -> (t[@mel.this]) -> int option = "codePointAt"
[@@mel.send] [@@mel.return undefined_to_opt]
(** Returns a nonnegative integer Number that is the code point value of the
    UTF-16 encoded code point starting at the specified [pos]. *)

external concat : t array -> (t[@mel.this]) -> t = "concat"
[@@mel.send]
(** Combines the text of two (or more) strings and returns a new string. *)

external ends_with : suffix:t -> (t[@mel.this]) -> bool = "endsWith"
[@@mel.send]
(** Determines whether a string ends with the characters of the string [suffix].
*)

external starts_with : prefix:t -> (t[@mel.this]) -> bool = "startsWith"
[@@mel.send]
(** Determines whether a string ends with the characters of the string [prefix].
*)

external includes : sub:t -> (t[@mel.this]) -> bool = "includes"
[@@mel.send]
(** Determines whether the calling string contains [sub]. *)

external index_of : sub:t -> (t[@mel.this]) -> int = "indexOf"
[@@mel.send]
(** Returns the index within this string of the first occurrence of [sub], or
    [-1] if not found. *)

external last_index_of : sub:t -> (t[@mel.this]) -> int = "lastIndexOf"
[@@mel.send]
(** Returns the index within this string of the last occurrence of [sub], or
    [-1] if not found. *)

external is_well_formed : t -> bool = "isWellFormed"
[@@mel.send]
(** Returns a boolean indicating whether this string contains any lone
    surrogates. *)

external to_well_formed : t -> t = "toWellFormed"
[@@mel.send]
(** Returns a string where all lone surrogates of this string are replaced with
    the Unicode replacement character U+FFFD. *)

external normalize :
  ?form:[ `NFC | `NFD | `NFKC | `NFKD ] -> (t[@mel.this]) -> t = "normalize"
[@@mel.send]
(** Returns the Unicode Normalization Form of the calling string value. *)

external replace : sub:t -> by:t -> (t[@mel.this]) -> t = "replace"
[@@mel.send]
(** Replace the first occurrence of [sub] with [by]. *)

external replace_re : pattern:Reg_exp.t -> by:t -> (t[@mel.this]) -> t
  = "replace"
[@@mel.send]
(** Replace the first occurrence of [pattern] with [by]. *)

external replace_all : sub:t -> by:t -> (t[@mel.this]) -> t = "replaceAll"
[@@mel.send]
(** Replace all occurrences of [sub] with [by]. *)

external replace_all_re : sub:t -> by:t -> (t[@mel.this]) -> t = "replaceAll"
[@@mel.send]
(** Replace all occurrences of [pattern] with [by]. *)

external match_ : pattern:Reg_exp.t -> (t[@mel.this]) -> Reg_exp_match.t option
  = "match"
[@@mel.send] [@@mel.return null_to_opt]
(** Match a regular expression against a string. *)

external match_all :
  pattern:Reg_exp.t -> (t[@mel.this]) -> Reg_exp_match.t Iterator.t = "matchAll"
[@@mel.send]
(** Returns an iterator of all [pattern]'s matches. *)

external search : pattern:Reg_exp.t -> (t[@mel.this]) -> int = "search"
[@@mel.send]
(** Search for a match between a regular expression [pattern] and the calling
    string.
    @return
      the index within this string of the match of [pattern] or [-1] if not
      found. *)

external pad_start : width:int -> fill:t -> (t[@mel.this]) -> t = "padStart"
[@@mel.send]
(** Pads the current string from the end with a given [fill] string and returns
    a new string of the length [width]. *)

external pad_end : width:int -> fill:t -> (t[@mel.this]) -> t = "padEnd"
[@@mel.send]
(** Pads the current string from the start with a given [fill] string and
    returns a new string of the length [width]. *)

external repeat : count:int -> (t[@mel.this]) -> t = "repeat"
[@@mel.send]
(** Returns a string consisting of the elements of the object *)

external slice : start:int -> ?end_:int -> (t[@mel.this]) -> t = "slice"
[@@mel.send]
(** Extract a section of a string and returns a new string. *)

external split : sep:string -> ?limit:int -> (t[@mel.this]) -> t array = "split"
[@@mel.send]
(** Returns an array of strings populated by splitting the calling string at
    occurrences of the substring [sep]. *)

external split_re :
  pattern:Reg_exp.t -> ?limit:int -> (t[@mel.this]) -> t option array = "split"
[@@mel.send]
(** Returns an array of strings populated by splitting the calling string at
    occurrences of the pattern [pattern]. *)

external substring : start:int -> ?end_:int -> (t[@mel.this]) -> t = "substring"
[@@mel.send]
(** Returns a new string containing characters of the calling string from (or
    between) the specified index (or indices). *)

external to_lower_case : t -> t = "toLowerCase"
[@@mel.send]
(** Returns the calling string value converted to lowercase. *)

external to_upper_case : t -> t = "toUpperCase"
[@@mel.send]
(** Returns the calling string value converted to uppercase. *)

external to_locale_lower_case : ?locales:string -> (t[@mel.this]) -> t
  = "toLocaleLowerCase"
[@@mel.send]
(** Returns the calling string value converted to lowercase respecting the
    current locale, or [locales] if passed. *)

external to_locale_upper_case : ?locales:string -> (t[@mel.this]) -> t
  = "toLocaleUpperCase"
[@@mel.send]
(** Returns the calling string value converted to uppercase respecting the
    current locale, or [locales] if passed. *)

external locale_compare : other:string -> ?locales:string -> (t[@mel.this]) -> t
  = "localeCompare"
[@@mel.send]
(** Returns a number indicating whether the reference string [other] comes
    before, after, or is equivalent to the given string in sort order. *)

external trim : t -> t = "trim"
[@@mel.send]
(** Trims whitespace from the beginning and end of the string. *)

external trim_end : t -> t = "trimEnd"
[@@mel.send]
(** Trims whitespace from the end of the string. *)

external trim_start : t -> t = "trimStart"
[@@mel.send]
(** Trims whitespace from the end of the string. *)

(** {1 Iterators} *)

external as_array_like : t -> t Array_like.t = "%identity"
(** Cast to {!Array_like.t}. *)

external as_iterable : t -> t Iterable.t = "%identity"
(** Cast to {!Iterable.t}. *)
