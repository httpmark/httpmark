module HttpArchive.Views exposing (log, entry, css)

import Html exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Css exposing (..)
import Css.Elements as E
import Css.Namespace exposing (namespace)
import HttpArchive.Types exposing (Log, Entry)


{ id, class, classList } =
    withNamespace "HttpArchive"


type CssClases
    = Log
    | Entries
    | Entry


css : List Snippet
css =
    namespace "HttpArchive" <|
        [ (.) Log
            [ margin2 zero auto ]
        , (.) Entries
            [ border3 (px 1) solid (rgb 200 200 200)
            , property "border-collapse" "collapse"
            , fontSize (px 12)
            , color (rgb 100 100 100)
            , descendants
                [ each [ E.td, E.th ]
                    [ padding (Css.em 0.5)
                    , border3 (px 1) solid (rgb 200 200 200)
                      -- collapse is not exposed?
                    , borderTop zero
                    , borderBottom zero
                    ]
                , E.th
                    [ borderBottom3 (px 1) solid (rgb 200 200 200) ]
                ]
            ]
        , (.)
            Entry
            [ nthChild "odd"
                [ backgroundColor (rgb 240 240 240)
                ]
            ]
        ]


log : Log -> Html msg
log log =
    let
        -- Use the first page of the HAR (for now)
        page =
            List.head log.pages

        title =
            case page of
                Just page ->
                    Html.text page.title

                Nothing ->
                    Html.text ""

        contentLoad =
            case page of
                Just page ->
                    truncate page.pageTimings.onContentLoad

                Nothing ->
                    "?"
    in
        div [ class [ Log ] ]
            [ h2 [] [ title ]
            , p []
                [ Html.text ("content loaded in " ++ contentLoad ++ " ms") ]
            , entries log.entries
            ]


entries : List Entry -> Html msg
entries entries =
    table [ class [ Entries ] ]
        [ thead []
            [ tr []
                [ th [] [ Html.text "URL" ]
                , th [] [ Html.text "Method" ]
                , th [] [ Html.text "Status" ]
                , th [] [ Html.text "Size" ]
                , th [] [ Html.text "Time" ]
                ]
            ]
        , tbody [] <| List.map entry entries
        ]


entry : Entry -> Html msg
entry entry =
    tr [ class [ Entry ] ]
        [ td [] [ Html.text (String.left 100 entry.request.url) ]
        , td [] [ Html.text entry.request.method ]
        , td [] [ Html.text (toString entry.response.status) ]
        , td [] [ Html.text ((toString entry.response.content.size) ++ " B") ]
        , td [] [ Html.text ((truncate entry.time) ++ " ms") ]
        ]


truncate : Float -> String
truncate number =
    ((number * 100) |> Basics.round |> toFloat) / 100 |> toString
