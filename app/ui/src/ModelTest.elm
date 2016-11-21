module ModelTest exposing (all)

import Test exposing (..)
import Expect
import Expectations as MyExpect
import Model exposing (fromJson)


all : Test
all =
    describe "Model"
        [ describe "fromJson"
            [ test "decodes a valid server response" <|
                \_ ->
                    let
                        input =
                            "{\"messages\":[\"one\",\"two\"]}"

                        expected =
                            Ok [ "one", "two" ]
                    in
                        Expect.equal expected (fromJson input)
            , test "decodes an empty valid server response" <|
                \_ ->
                    let
                        input =
                            "{\"messages\":[]}"

                        expected =
                            Ok []
                    in
                        Expect.equal expected (fromJson input)
            , test "returns error for an invalid JSON" <|
                \_ ->
                    let
                        input =
                            "{\"messages\":[\"one,\"two\"]}"
                    in
                        MyExpect.err (fromJson input)
            , test "returns error for a JSON of a wrong shape" <|
                \_ ->
                    let
                        input =
                            "{\"messages\": {\"first\":\"one\",\"second\":\"two\"}}"
                    in
                        MyExpect.err (fromJson input)
            ]
        ]
