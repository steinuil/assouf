open Es
open Node

type recursive = { name : string; child : recursive option }
type client = { id : int; application_name : string }
type node = { id : int; state : string }
type interface = Client of client | Node of node

let tests =
  Test.describe "Json.parse" (fun () ->
      Test.it "should raise a Syntax exception" (fun () ->
          try Json.parse {| [{ |} |> ignore with Exn.Syntax _ -> ()));

  Test.describe "Json.Decode" (fun () ->
      let open Json in
      let test_decoder message ~decoder ~json ~expected =
        Test.test message (fun () ->
            let decoded = Decode.parse ~decoder json in
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
             });

      test_decoder "complex nested decoder"
        ~decoder:
          (let open Decode in
           let client : client t =
             let* id = field "id" int in
             let* application_name =
               field "info" (field "props" (field "application.name" string))
             in
             return { id; application_name }
           in
           let node : node t =
             let* id = field "id" int in
             let* state = field "info" (field "state" string) in
             return { id; state }
           in

           let* type_ = field "type" string in
           match type_ with
           | "PipeWire:Interface:Client" ->
               let* client = client in
               return (Client client)
           | "PipeWire:Interface:Node" ->
               let* node = node in
               return (Node node)
           | _ -> expected "interface type")
        ~json:
          {json|
            {
              "id": 56,
              "type": "PipeWire:Interface:Client",
              "info": {
                "props": {
                  "application.name": "Firefox"
                }
              }
            }
          |json}
        ~expected:(Ok (Client { id = 56; application_name = "Firefox" })))
