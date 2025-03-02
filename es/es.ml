(** {1 Basic types} *)

module Boolean = Es0.Boolean
module Float = Float
module Int = Es0.Int
module Big_int = Es0.Big_int
module String = String
module Symbol = Es0.Symbol
module Exn = Exn

(** {2 [undefined] and [null]} *)

module Undefined = Es0.Undefined
module Null = Null
module Nullish = Nullish

(** {1 Collections} *)

module Array = Array
module Dict = Dict
module Map = Es0.Map
module Set = Es0.Set
module Weak_map = Es0.Weak_map
module Weak_set = Es0.Weak_set

(** {2 Typed arrays} *)

module Array_buffer = Es0.Array_buffer
module Shared_array_buffer = Es0.Shared_array_buffer
module Data_view = Es0.Data_view
module Int8_array = Es0.Int8_array
module Uint8_array = Es0.Uint8_array
module Uint8_clamped_array = Es0.Uint8_clamped_array
module Int16_array = Es0.Int16_array
module Uint16_array = Es0.Uint16_array
module Int32_array = Es0.Int32_array
module Uint32_array = Es0.Uint32_array
module Big_int64_array = Es0.Big_int64_array
module Big_uint64_array = Es0.Big_uint64_array
module Float16_array = Es0.Float16_array
module Float32_array = Es0.Float32_array
module Float64_array = Es0.Float64_array

(** {1 Iterators and control flow abstractions} *)

module Iterable = Iterable
module Iterator = Es0.Iterator
module Async_iterable = Es0.Async_iterable
module Async_iterator = Es0.Async_iterator
module Iterator_result = Es0.Iterator_result
module Array_like = Array_like
module Promise = Promise
module Promise_outcome = Es0.Promise_outcome
module Generator = Es0.Generator
module Async_generator = Es0.Async_generator

(** {1 Reflection and unsafe operations} *)

module Object = Object
module Reflect = Reflect
module Weak_ref = Es0.Weak_ref
module Finalization_registry = Es0.Finalization_registry
module Proxy = Es0.Proxy

(** {1 Built-in APIs} *)

module Reg_exp = Es0.Reg_exp
module Reg_exp_match = Es0.Reg_exp_match
module Date = Es0.Date
module Temporal = Es0.Temporal
module Uri = Es0.Uri
module Json = Json
