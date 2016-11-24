module Model exposing (..)

import HttpArchive exposing (Log, fromJson)


type Output
    = Archive Log
    | Status String


type alias Model =
    { query : String
    , output : Output
    }


updateFromResponse : Result String Log -> Model -> Model
updateFromResponse response model =
    case response of
        Err err ->
            { model | output = Status err }

        Ok log ->
            { model | output = Archive log }
