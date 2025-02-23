external ( = ) : int -> int -> bool = "%eq"
external ( <> ) : int -> int -> bool = "%noteq"
external ( == ) : 'a -> 'a -> bool = "%eq"
external ( < ) : int -> int -> bool = "%lessthan"
external ( > ) : int -> int -> bool = "%greaterthan"
external ( |> ) : 'a -> ('a -> 'b) -> 'b = "%revapply"

module Result = Stdlib.Result
module Option = Stdlib.Option

type ('v, 'e) result = ('v, 'e) Result.t = Ok of 'v | Error of 'e

external ( != ) : 'a -> 'a -> bool = "%noteq"
external not : bool -> bool = "%boolnot"
external ( && ) : bool -> bool -> bool = "%sequand"
external ( || ) : bool -> bool -> bool = "%sequor"
external ( ^ ) : string -> string -> string = "#string_append"
external ignore : 'a -> unit = "%ignore"
external ( + ) : int -> int -> int = "%addint"
external ( - ) : int -> int -> int = "%subint"
external ( * ) : int -> int -> int = "%mulint"
external ( / ) : int -> int -> int = "%divint"
external ( mod ) : int -> int -> int = "%modint"
