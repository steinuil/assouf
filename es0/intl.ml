external get_canonical_locales : string array -> string array
  = "getCanonicalLocales"
[@@mel.scope "Intl"]

external supported_values_of :
  [ `calendar
  | `collation
  | `currency
  | `numbering_system [@mel.as "numberingSystem"]
  | `time_zone [@mel.as "timeZone"]
  | `unit ] ->
  string array = "supportedValuesOf"
[@@mel.scope "Intl"]
