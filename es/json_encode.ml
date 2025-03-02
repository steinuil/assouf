open Json

let stringify ~space v = stringify ~space (of_value v)
let string v = String v
let bool v = Boolean v
let int v = Number (Es0.Int.as_float v)
let float v = Number v
let null = Null
let option f v = match v with Some v -> f v | None -> null
let array f arr = Array (Array.map ~f arr)
let set f set = Array (Array.of_iterable_map ~f (Es0.Set.as_iterable set))
let iterable f it = Array (Array.of_iterable_map ~f it)
let object_ arr = Object (Dict.of_array arr)
let dict dict = Object dict
