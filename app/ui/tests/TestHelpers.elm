module TestHelpers exposing (equalityTests)

import Test exposing (..)
import Expect


type alias EqualityTest outputType =
    { description : String
    , output : outputType
    , expected : outputType
    }


equalityTest : EqualityTest out -> Test
equalityTest { description, output, expected } =
    test description <|
        \_ -> Expect.equal expected output


equalityTests : List (EqualityTest out) -> List Test
equalityTests =
    List.map equalityTest
