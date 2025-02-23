open Es
open Node

type test = { ayy : string; lmao : int }
type recursive = { name : string; child : recursive option }

let () =
  Test.describe "Json.parse" (fun () ->
      Test.it "should raise a Syntax exception" (fun () ->
          try Json.parse {| [{ |} |> ignore with Exn.Syntax _ -> ()))

let () =
  Test.describe "Json.Decode" (fun () ->
      Test.it "should retrieve fields" (fun () ->
          let decoder = Json.Decode.(array (optional (field "ayy" string))) in
          let decoded =
            Json.parse_with ~decoder
              {json|
            [
              {"ayy": "lmao"},
              {"ayy": "tfw", "lmao": "gf"},
              {"yo": "test"}
            ]
          |json}
          in
          Assert.deep_strict_equal decoded
            (Ok [| Some "lmao"; Some "tfw"; None |]));

      Test.it "should return an appropriate error" (fun () ->
          let decoded =
            Json.parse_with
              ~decoder:Json.Decode.(array (field "ayy" string))
              {json|
                [
                  {"ayy": "lmao"},
                  {"ayy": "tfw", "lmao": "gf"},
                  {"yo": "test"}
                ]
              |json}
          in
          let error =
            let open Json.Decode in
            let dict =
              Json.Object (Es0.Dict.of_array [| ("yo", Json.String "test") |])
            in
            Index (2, Field ("ayy", Failed ("field not found", dict)))
          in
          Assert.deep_strict_equal decoded (Error error));

      Test.it "should map things to the thing" (fun () ->
          let decoder =
            let open Json.Decode in
            array
              (map2
                 ~f:(fun ayy lmao -> { ayy; lmao })
                 (field "ayy" string) (field "lmao" int))
          in
          let decoded =
            Json.parse_with ~decoder
              {|
               [
                 {"ayy": "test", "lmao": 22},
                 {"ayy": "Madoka", "lmao": 4123}
               ] 
              |}
          in
          Assert.deep_strict_equal decoded
            (Ok
               [|
                 { ayy = "test"; lmao = 22 }; { ayy = "Madoka"; lmao = 4123 };
               |]));

      Test.it "should be able to deal with recursive data structures" (fun () ->
          let rec decoder () =
            Json.Decode.(
              map2
                ~f:(fun name child -> { name; child })
                (field "name" string)
                (field "child" (option (lazy_ decoder))))
          in
          let decoded =
            Json.parse_with ~decoder:(decoder ())
              {|
            {
              "name": "Bjorn",
              "child": {
                "name": "Bjornsson",
                "child": null
              }
            }
        |}
          in
          Assert.deep_strict_equal decoded
            (Ok
               {
                 name = "Bjorn";
                 child = Some { name = "Bjornsson"; child = None };
               })))
