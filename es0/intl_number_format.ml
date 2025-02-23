(* TODO *)

type options
(** Formatting options for numbers. *)

external options :
  ?localeMatcher:[ `lookup | `best_fit [@mel.as "best fit"] ] ->
  ?numberingSystem:string ->
  ?style:[ `decimal | `currency | `percent | `unit ] ->
  ?currency:string ->
  ?currencyDisplay:
    [ `code | `symbol | `narrow_symbol [@mel.as "narrowSymbol"] | `name ] ->
  ?currencySign:[ `standard | `accounting ] ->
  ?unit:string ->
  ?unitDisplay:[ `short | `narrow | `long ] ->
  ?minimumIntegerDigits:int ->
  ?minimumFractionDigits:int ->
  ?maximumFractionDigits:int ->
  ?minimumSignificantDigits:int ->
  ?maximumSignificantDigits:int ->
  ?roundingPriority:
    [ `auto
    | `more_precision [@mel.as "morePrecision"]
    | `less_precision [@mel.as "lessPrecision"] ] ->
  ?roundingIncrement:int ->
  ?roundingMode:
    [ `ceil
    | `floor
    | `expand
    | `trunc
    | `half_ceil [@mel.as "halfCeil"]
    | `half_floor [@mel.as "halfFloor"]
    | `half_expand [@mel.as "halfExpand"]
    | `half_trunc [@mel.as "halfTrunc"]
    | `half_even [@mel.as "halfEven"] ] ->
  ?trailingZeroDisplay:[ `auto | `stripIfInteger ] ->
  ?notation:[ `standard | `scientific | `engineering | `compact ] ->
  ?compactDisplay:[ `short | `long ] ->
  ?useGrouping:[ `always | `auto | `min2 | `false_ [@mel.as "false"] ] ->
  ?signDisplay:
    [ `auto
    | `always
    | `except_zero [@mel.as "exceptZero"]
    | `negative
    | `never ] ->
  unit ->
  options = ""
[@@mel.obj]
