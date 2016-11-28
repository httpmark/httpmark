module HttpArchive.Views exposing (log, entry)

import Html exposing (..)
import HttpArchive.Types exposing (Log, Entry)


log : Log -> Html msg
log log =
    let
        -- Use the first page of the HAR (for now)
        page =
            List.head log.pages

        title =
            case page of
                Just page ->
                    text page.title

                Nothing ->
                    text ""

        contentLoad =
            case page of
                Just page ->
                    truncate page.pageTimings.onContentLoad

                Nothing ->
                    "?"
    in
        div []
            [ h2 [] [ title ]
            , p []
                [ text ("content loaded in " ++ contentLoad ++ " ms") ]
            , entries log.entries
            ]


entries : List Entry -> Html msg
entries entries =
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
        , tbody [] <| List.map entry entries
        ]


entry : Entry -> Html msg
entry entry =
    tr []
        [ td [] [ text (String.left 100 entry.request.url) ]
        , td [] [ text entry.request.method ]
        , td [] [ text (toString entry.response.status) ]
        , td [] [ text ((toString entry.response.content.size) ++ " B") ]
        , td [] [ text ((truncate entry.time) ++ " ms") ]
        ]


truncate : Float -> String
truncate number =
    ((number * 100) |> round |> toFloat) / 100 |> toString
