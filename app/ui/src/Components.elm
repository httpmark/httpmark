module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Css exposing (..)
import Css.Elements as E
import Css.Namespace exposing (namespace)
import HttpArchive.Views exposing (log)
import Model exposing (Output(..))


css : Css.Stylesheet
css =
    (stylesheet << namespace "httpmark")
        [ E.body
            [ backgroundColor (Css.rgb 250 250 250)
            , fontFamilies [ "Helvetica", "sans-serif" ]
            ]
        ]


layout : List (Html msg) -> Html msg
layout children =
    div [] children


query : (String -> msg) -> msg -> Html msg
query queryChange submit =
    Html.form [ onSubmit submit ]
        [ label [ for "query" ] [ Html.text "Your query: " ]
        , input [ id "query", onInput queryChange ] []
        , button [ type_ "submit", onClick submit ] [ Html.text "Update" ]
        ]


output : Output -> Html msg
output output =
    case output of
        Status message ->
            p [] [ Html.text message ]

        Archive l ->
            log l
