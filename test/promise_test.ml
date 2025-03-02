open Es
open Node

let tests =
  Test.async_test "Promise syntax" (fun () ->
      let open Promise.Syntax in
      let* v = Promise.resolve "Ina" and* v2 = Promise.resolve "Ina" in
      Assert.deep_strict_equal (v ^ v2) "InaIna" |> Promise.resolve)
