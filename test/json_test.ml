open Es
open Node

type recursive = { name : string; child : recursive option }

let tests =
  Test.describe "Json.parse" (fun () ->
      Test.it "should raise a Syntax exception" (fun () ->
          try Json.parse {| [{ |} |> ignore with Exn.Syntax _ -> ()));

  Test.describe "Json.Decode" (fun () ->
      let open Json in
      let test_decoder message ~decoder ~json ~expected =
        Test.test message (fun () ->
            let decoded = Decode.parse_with ~decoder json in
            Assert.deep_strict_equal decoded expected)
      in

      test_decoder "'field' retrieves the correct field in the object"
        ~decoder:Decode.(array (optional (field "name" string)))
        ~json:
          {json|
            [
              {"name": "Madoka"},
              {"nick": "Homuhomu", "name": "Homura"},
              {"monster": "Kyubei"}
            ]
          |json}
        ~expected:(Ok [| Some "Madoka"; Some "Homura"; None |]);

      Test.describe
        "returns errors indicating the path taken through the JSON object"
        (fun () ->
          test_decoder "Index and Field"
            ~decoder:Decode.(array (field "name" string))
            ~json:
              {json|
                [
                  {"name": "Madoka"},
                  {"name": 3},
                  {"name": "Mami", "mamis": true}
                ]
              |json}
            ~expected:
              (let open Decode in
               Error
                 (Index (1, Field ("name", Expected ("string", Number 3.0)))));

          test_decoder "field not found"
            ~decoder:Decode.(array (field "age" int))
            ~json:
              {json|
                [
                  {"age": 3},
                  {"name": "Kazumi"},
                  {"age": 49}
                ]
              |json}
            ~expected:
              (let open Decode in
               let dict =
                 Object (Dict.of_array [| ("name", String "Kazumi") |])
               in
               Error
                 (Index (1, Field ("age", Failed ("field not found", dict))))));

      test_decoder "it should deal with recursive data structures"
        ~decoder:
          (let rec decoder () =
             let open Decode in
             let* name = field "name" string
             and* child = field "child" (option (lazy_ decoder)) in
             return { name; child }
           in
           decoder ())
        ~json:
          {json|
            {
              "name": "Bjorn",
              "child": {
                "name": "Bjornsson",
                "child": null
              }
            }
          |json}
        ~expected:
          (Ok
             {
               name = "Bjorn";
               child = Some { name = "Bjornsson"; child = None };
             }))
