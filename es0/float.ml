(** JavaScript [Number]s represented as double-precision 64-bit IEEE 754 floats.
*)

type t = float
(** The JavaScript [Number] type. *)

(** {1 Constants} *)

external epsilon : t = "EPSILON"
[@@mel.scope "Number"]
(** The smallest interval between two representable numbers. *)

external max_value : t = "MAX_VALUE"
[@@mel.scope "Number"]
(** The largest positive representable number. *)

external min_value : t = "MIN_VALUE"
[@@mel.scope "Number"]
(** The smallest positive representable number—that is, the positive number
    closest to zero (without actually being zero). *)

external nan : t = "NaN"
[@@mel.scope "Number"]
(** Special "Not a Number" value. *)

external negative_infinity : t = "NEGATIVE_INFINITY"
[@@mel.scope "Number"]
(** Special value representing negative infinity. Returned on overflow. *)

external positive_infinity : t = "POSITIVE_INFINITY"
[@@mel.scope "Number"]
(** Special value representing infinity. Returned on overflow. *)

(** {2 Mathematical constants} *)

external e : t = "E"
[@@mel.scope "Math"]
(** Euler's number and the base of natural logarithms; approximately 2.718. *)

external ln10 : t = "LN10"
[@@mel.scope "Math"]
(** Natural logarithm of 10; approximately 2.303. *)

external ln2 : t = "LN2"
[@@mel.scope "Math"]
(** Natural logarithm of 2; approximately 0.693. *)

external log10e : t = "LOG10E"
[@@mel.scope "Math"]
(** Base-10 logarithm of E; approximately 0.434. *)

external log2e : t = "LOG2E"
[@@mel.scope "Math"]
(** Base-2 logarithm of E; approximately 1.443. *)

external pi : t = "PI"
[@@mel.scope "Math"]
(** Ratio of a circle's circumference to its diameter; approximately 3.14159. *)

external sqrt1_2 : t = "SQRT1_2"
[@@mel.scope "Math"]
(** Square root of ½; approximately 0.707. *)

external sqrt2 : t = "SQRT2"
[@@mel.scope "Math"]
(** Square root of 2; approximately 1.414. *)

(** {1 Checks} *)

external is_finite : t -> bool = "isFinite"
[@@mel.scope "Number"]
(** Determine whether the passed value is a finite number. *)

external is_integer : t -> bool = "isInteger"
[@@mel.scope "Number"]
(** Determine whether the passed value is an integer. *)

external is_nan : t -> bool = "isNaN"
[@@mel.scope "Number"]
(** Determine whether the passed value is {{!nan} NaN}. *)

external is_safe_integer : t -> bool = "isSafeInteger"
[@@mel.scope "Number"]
(** Determine whether the passed value is a safe integer (number between
    -(2{^ 53} - 1) and 2{^ 53} - 1). *)

(** {1 Operations} *)

external ( ** ) : t -> t -> t = "pow"
[@@mel.scope "Math"]
(** Alias to {!pow}. *)

external max : t array -> t = "max"
[@@mel.scope "Math"] [@@mel.variadic]
(** Returns the largest of zero or more numbers. *)

external min : t array -> t = "min"
[@@mel.scope "Math"] [@@mel.variadic]
(** Returns the smallest of zero or more numbers. *)

external abs : t -> t = "abs"
[@@mel.scope "Math"]
(** Returns the absolute value of the input. *)

external sign : t -> int = "sign"
[@@mel.scope "Math"]
(** Returns the sign of the input, indicating whether it is positive, negative,
    or zero. *)

external random : unit -> t = "random"
[@@mel.scope "Math"]
(** Returns a pseudo-random number between 0 and 1. *)

(** {2 Exponential and logarithmic} *)

external pow : t -> exponent:t -> t = "pow"
[@@mel.scope "Math"]
(** Returns base [x] to the exponent power [exponent] (that is, x{^ exponent})
*)

external exp : t -> t = "exp"
[@@mel.scope "Math"]
(** Returns e{^ x}, where x is the argument, and e is Euler's number (2.718...,
    the base of the natural logarithm.) *)

external expm1 : t -> t = "expm1"
[@@mel.scope "Math"]
(** Returns subtracting 1 from {{!exp} [exp x]} *)

external sqrt : t -> t = "sqrt"
[@@mel.scope "Math"]
(** Returns the positive square root of the input. *)

external cbrt : t -> t = "cbrt"
[@@mel.scope "Math"]
(** Returns the cube root of the input. *)

external hypot : t array -> t = "hypot"
[@@mel.scope "Math"] [@@mel.variadic]
(** Returns the square root of the sum of squares of its arguments. *)

external log : t -> t = "log"
[@@mel.scope "Math"]
(** Returns the natural logarithm (log{_ e}; also, ln) of the input. *)

external log10 : t -> t = "log10"
[@@mel.scope "Math"]
(** Returns the base-10 logarithm of the input. *)

external log1p : t -> t = "log1p"
[@@mel.scope "Math"]
(** Returns the natural logarithm (log{_ e}; also ln) of [1 + x] for the number
    [x]. *)

external log2 : t -> t = "log2"
[@@mel.scope "Math"]
(** Returns the base-2 logarithm of the input. *)

(** {2 Trigonometric} *)

external sin : t -> t = "sin"
[@@mel.scope "Math"]
(** Returns the sine of the input. *)

external cos : t -> t = "cos"
[@@mel.scope "Math"]
(** Returns the cosine of the input. *)

external tan : t -> t = "tan"
[@@mel.scope "Math"]
(** Returns the tangent of the input. *)

external asin : t -> t = "asin"
[@@mel.scope "Math"]
(** Returns the arcsine of the input. *)

external acos : t -> t = "acos"
[@@mel.scope "Math"]
(** Returns the arccosine of the input. *)

external atan : t -> t = "atan"
[@@mel.scope "Math"]
(** Returns the arctangent of the input. *)

external atan2 : y:t -> x:t -> t = "atan2"
[@@mel.scope "Math"]
(** Returns the arctangent of the quotient of its arguments. *)

(** {2 Hyperbolic} *)

external sinh : t -> t = "sinh"
[@@mel.scope "Math"]
(** Returns the hyperbolic sine of the input. *)

external cosh : t -> t = "cosh"
[@@mel.scope "Math"]
(** Returns the hyperbolic cosine of the input. *)

external tanh : t -> t = "tanh"
[@@mel.scope "Math"]
(** Returns the hyperbolic tangent of the input. *)

external asinh : t -> t = "asinh"
[@@mel.scope "Math"]
(** Returns the hyperbolic arcsine of a number. *)

external acosh : t -> t = "acosh"
[@@mel.scope "Math"]
(** Returns the hyperbolic arccosine of the input. *)

external atanh : t -> t = "atanh"
[@@mel.scope "Math"]
(** Returns the hyperbolilc arctangent of the input. *)

(** {1 Parsing and serializing} *)

external unsafe_of_string : string -> t = "parseFloat"
[@@mel.scope "Number"]
(** Parses a string containing a number literal using parseFloat.
    @return {{!nan} NaN} on failure. *)

external of_string : string -> t = "Number"
(** Parses a string containing a number literal into a float. *)

external unsafe_as_int : t -> int = "%identity"
(** Casts a float value to an int performing no conversion. *)

external to_exponential : ?digits:int -> (t[@mel.this]) -> string
  = "toExponential"
[@@mel.send]
(** Returns a string representing the number in exponential notation. *)

external to_fixed : ?digits:int -> (t[@mel.this]) -> string = "toFixed"
[@@mel.send]
(** Returns a string representing the number in fixed-point notation. *)

external to_precision : ?digits:int -> (t[@mel.this]) -> string = "toPrecision"
[@@mel.send]
(** Returns a string representing the number in fixed-point or exponential
    notation. *)

external to_string : ?radix:int -> (t[@mel.this]) -> string = "toString"
[@@mel.send]
(** Returns a string representing the specified object in the specified radix
    ("base"). *)

external to_locale_string :
  ?locales:string ->
  ?options:Intl_number_format.options ->
  (t[@mel.this]) ->
  string = "toLocaleString"
[@@mel.send]
(** Returns a string with a language-sensitive representation of the float. *)

(** {1 Rounding} *)

external round : t -> int = "round"
[@@mel.scope "Math"]
(** Returns the value of the input rounded to the nearest integer. *)

external ceil : t -> int = "ceil"
[@@mel.scope "Math"]
(** Returns the smallest integer greater than or equal to the input. *)

external floor : t -> int = "floor"
[@@mel.scope "Math"]
(** Returns the largest integer less than or equal to the input. *)

external trunc : t -> int = "trunc"
[@@mel.scope "Math"]
(** Returns the integer portionl of the input, removing any fractional digits.
*)

external f16round : t -> t = "f16round"
[@@mel.scope "Math"]
(** Returns the nearest half precision float representation of the input. *)

external fround : t -> t = "fround"
[@@mel.scope "Math"]
(** Returns the nearest single precision float representation of the input. *)
