open Es0

type +'a t = 'a Nullish.t
type +'a kind = Value of 'a | Null | Undefined
