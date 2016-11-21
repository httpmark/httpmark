module Expectations exposing (..)

import Expect exposing (Expectation)


err : Result a b -> Expectation
err result =
    case result of
        Ok _ ->
            Expect.fail ("Expected Err but got: " ++ toString result)

        Err _ ->
            Expect.pass
