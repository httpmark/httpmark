module Model exposing (..)

import HttpArchive


type Output
    = Archive HttpArchive.Log
    | Status String


type alias Model =
    { query : String
    , output : Output
    }


updateFromResponse : Result String HttpArchive.Log -> Model -> Model
updateFromResponse response model =
    case response of
        Err err ->
            { model | output = Status err }

        Ok log ->
            { model | output = Archive log }
