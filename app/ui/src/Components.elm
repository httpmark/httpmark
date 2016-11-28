module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import HttpArchive.Views exposing (log)
import Model exposing (Output(..))


layout : List (Html msg) -> Html msg
layout children =
    div [] children


query : (String -> msg) -> msg -> Html msg
query queryChange submit =
    Html.form [ onSubmit submit ]
        [ label [ for "query" ] [ text "Your query: " ]
        , input [ id "query", onInput queryChange ] []
        , button [ type_ "submit", onClick submit ] [ text "Update" ]
        ]


output : Output -> Html msg
output output =
    case output of
        Status message ->
            p [] [ text message ]

        Archive l ->
            log l
