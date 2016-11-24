module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Model exposing (Output(..))
import HttpArchive


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

        Archive log ->
            harLog log



-- HAR components
-- TODO extract these out into the HttpArchive viewer


harLog : HttpArchive.Log -> Html msg
harLog log =
    table []
        [ thead []
            [ tr []
                [ th [] [ text "URL" ]
                , th [] [ text "Method" ]
                , th [] [ text "Status" ]
                , th [] [ text "Size" ]
                , th [] [ text "Time" ]
                ]
            ]
        , tbody [] <| List.map harEntry log.entries
        ]


truncate : Float -> String
truncate number =
    ((number * 100) |> round |> toFloat) / 100 |> toString


harEntry : HttpArchive.Entry -> Html msg
harEntry entry =
    tr []
        [ td [] [ text (String.left 100 entry.request.url) ]
        , td [] [ text entry.request.method ]
        , td [] [ text (toString entry.response.status) ]
        , td [] [ text ((toString entry.response.content.size) ++ " B") ]
        , td [] [ text ((truncate entry.time) ++ " ms") ]
        ]
