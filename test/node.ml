module Test = struct
  external test : string -> (unit -> unit) -> unit = "test"
  [@@mel.module "node:test"]

  external describe : string -> (unit -> unit) -> unit = "describe"
  [@@mel.module "node:test"]

  external it : string -> (unit -> unit) -> unit = "it"
  [@@mel.module "node:test"]
end

module Assert = struct
  external deep_strict_equal : 'a -> 'a -> unit = "deepStrictEqual"
  [@@mel.module "node:assert/strict"]
end
