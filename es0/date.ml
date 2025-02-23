(** Platform-independent representation of a single moment in time.

    Locale-specific functions are intentionally left out; use {!Temporal}
    instead. *)

type t
(** A JavaScript Date object. *)

external of_unix_timestamp : int -> t = "Date"
[@@mel.new]
(** Create a Date from a Unix timestamp representing the number of milliseconds
    since 1970-01-01 00:00:00. *)

external copy : t -> t = "Date" [@@mel.new]
(** Copy a Date object. *)

external of_ymd : year:int -> month_index:int -> day:int -> t = "Date"
[@@mel.new]
(** Create a Date from [year], a 0-based [month_index] and [day]. *)

external make :
  year:int ->
  month_index:int ->
  day:int ->
  hour:int ->
  minute:int ->
  second:int ->
  millisecond:int ->
  t = "Date"
[@@mel.new]
(** Create a Date from its components. *)

external now : unit -> t = "Date"
[@@mel.new]
(** Create a Date corresponding to the current time. *)

external parse : string -> t = "parse"
[@@mel.new]
(** Parse a string representation of a date into a Date. *)

external current_unix_timestamp : unit -> int = "now"
[@@mel.scope "Date"]
(** Return the Unix timestamp in milliseconds corresponding to the current time.
*)

external utc_of_ymd : year:int -> month_index:int -> day:int -> t = "UTC"
[@@mel.scope "Date"]
(** Create a Date with the timezone set to UTC from [year], a 0-based
    [month_index] and [day]. *)

external utc :
  year:int ->
  month_index:int ->
  day:int ->
  hour:int ->
  minute:int ->
  second:int ->
  millisecond:int ->
  t = "UTC"
[@@mel.scope "Date"]
(** Create a Date with the timezone set to UTC from its components. *)

external year : t -> int = "getFullYear"
[@@mel.send]
(** Returns the year of the specified date according to local time. *)

external month_index : t -> int = "getMonth"
[@@mel.send]
(** Returns the month index (0-11) of the specified date according to local
    time. *)

external day : t -> int = "getDate"
[@@mel.send]
(** Returns the day of the month (1-31) for the specified date according to
    local time. *)

external weekday : t -> int = "getDay"
[@@mel.send]
(** Returns the day of the week (0-6) for the specified date according to local
    time. *)

external hour : t -> int = "getHours"
[@@mel.send]
(** Returns the hour (0-23) in the specified date according to local time. *)

external minute : t -> int = "getMinutes"
[@@mel.send]
(** Returns the seconds (0-59) in the specified date according to local time. *)

external millisecond : t -> int = "getMilliseconds"
[@@mel.send]
(** Returns the milliseconds (0-999) in the specified date according to local
    time. *)

external to_unix_timestamp : t -> int = "getTime"
[@@mel.send]
(** Returns the Unix timestamp of the specified date according to local time. *)

external timezone_offset : t -> int = "getTimezoneOffset"
[@@mel.send]
(** Returns the timezone offset in minutes for the current locale. *)

external utc_year : t -> int = "getUTCFullYear"
[@@mel.send]
(** Returns the year of the specified date according to universal time. *)

external utc_month_index : t -> int = "getUTCMonth"
[@@mel.send]
(** Returns the month index (0-11) of the specified date according to universal
    time. *)

external utc_day : t -> int = "getUTCDate"
[@@mel.send]
(** Returns the day of the month (1-31) for the specified date according to
    universal time. *)

external utc_weekday : t -> int = "getUTCDay"
[@@mel.send]
(** Returns the day of the week (0-6) for the specified date according to
    universal time. *)

external utc_hour : t -> int = "getUTCHours"
[@@mel.send]
(** Returns the hour (0-23) in the specified date according to universal time.
*)

external utc_minute : t -> int = "getUTCMinutes"
[@@mel.send]
(** Returns the seconds (0-59) in the specified date according to universal
    time. *)

external utc_millisecond : t -> int = "getUTCMilliseconds"
[@@mel.send]
(** Returns the milliseconds (0-999) in the specified date according to
    universal time. *)

external to_iso8601_string : t -> string = "toISOString"
[@@mel.send]
(** Converts a date to a string following the ISO 8601 Extended Format. *)

external to_string : t -> string = "toString"
[@@mel.send]
(** Returns a string representing the date. *)

external to_utc_string : t -> string = "toUTCString"
[@@mel.send]
(** Converts a date to a string using the UTC timezone. *)

external to_date_string : t -> string = "toDateString"
[@@mel.send]
(** Returns the "date" portion of the Date as a human-readable string like 'Thu
    Apr 12 2018'. *)

external to_time_string : t -> string = "toTimeString"
[@@mel.send]
(** Returns the "time" portion of the date as a human-readable string. *)
