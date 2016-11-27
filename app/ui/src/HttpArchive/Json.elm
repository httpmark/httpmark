module HttpArchive.Json exposing (date)

import Json.Decode exposing (..)
import Date exposing (Date, fromString)


date : Decoder Date
date =
    string |> andThen dateString


dateString : String -> Decoder Date
dateString str =
    case fromString str of
        Err err ->
            fail err

        Ok d ->
            succeed d
