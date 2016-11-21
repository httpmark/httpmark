module Model exposing (..)

import Json.Decode as Decode


type alias Messages =
    List String


type Output
    = Messages Messages
    | Status String


type alias Model =
    { query : String
    , output : Output
    }


fromJson : String -> Result String Messages
fromJson message =
    let
        messageDecoder =
            Decode.at [ "messages" ] (Decode.list Decode.string)
    in
        Decode.decodeString messageDecoder message
