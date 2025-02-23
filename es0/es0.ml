(** Zero-cost bindings to JavaScript.

    [Es0] provides portable bindings to JavaScript's base language with the goal
    of being completely optimized away by Melange's compiler.

    It does not provide bindings to browser or Node.js interfaces (this includes
    [console.log]). *)

(** {1 Basic types} *)

module Boolean = Boolean
module Float = Float
module Int = Int
module Big_int = Big_int
module String = String
module Symbol = Symbol
module Error = Error

(** {2 [undefined] and [null]} *)

module Undefined = Undefined
module Null = Null
module Nullish = Nullish

(** {1 Collections} *)

module Array = Array
module Dict = Dict
module Map = Map
module Set = Set
module Weak_map = Weak_map
module Weak_set = Weak_set

(** {2 Typed arrays} *)

module Array_buffer = Array_buffer
module Shared_array_buffer = Shared_array_buffer
module Data_view = Data_view
module Int8_array = Int8_array
module Uint8_array = Uint8_array
module Uint8_clamped_array = Uint8_clamped_array
module Int16_array = Int16_array
module Uint16_array = Uint16_array
module Int32_array = Int32_array
module Uint32_array = Uint32_array
module Big_int64_array = Big_int64_array
module Big_uint64_array = Big_uint64_array
module Float16_array = Float16_array
module Float32_array = Float32_array
module Float64_array = Float64_array

(** {1 Iterators and control flow abstractions} *)

module Iterable = Iterable
module Iterator = Iterator
module Async_iterable = Async_iterable
module Async_iterator = Async_iterator
module Iterator_result = Iterator_result
module Array_like = Array_like
module Promise = Promise
module Promise_outcome = Promise_outcome
module Generator = Generator
module Async_generator = Async_generator

(** {1 Reflection and unsafe operations} *)

module Object = Object
module Reflect = Reflect
module Weak_ref = Weak_ref
module Finalization_registry = Finalization_registry
module Proxy = Proxy

(** {1 Built-in APIs} *)

module Reg_exp = Reg_exp
module Reg_exp_match = Reg_exp_match
module Date = Date
module Temporal = Temporal
module Uri = Uri
module Json = Json

(** {2 Internationalization} *)

module Intl = Intl
module Intl_collator = Intl_collator
module Intl_date_time_format = Intl_date_time_format
module Intl_display_names = Intl_display_names
module Intl_duration_format = Intl_duration_format
module Intl_list_format = Intl_list_format
module Intl_locale = Intl_locale
module Intl_number_format = Intl_number_format
module Intl_plural_rules = Intl_plural_rules
module Intl_relative_time_format = Intl_relative_time_format
module Intl_segmenter = Intl_segmenter
