module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Html.Events exposing (onClick, onInput, onSubmit)
import Css exposing (..)
import Css.Elements as E
import Css.Namespace exposing (namespace)
import HttpArchive.Views exposing (log)
import Model exposing (Output(..))


type CssClasses
    = Query
    | StatusText


{ id, class, classList } =
    withNamespace "httpmark"


globalStyles : List Snippet
globalStyles =
    [ E.body
        [ backgroundColor (Css.rgb 250 250 250)
        , fontFamilies [ "Helvetica", "sans-serif" ]
        ]
    ]


componentStyles : List Snippet
componentStyles =
    namespace "httpmark"
        [ statusStyles
        , queryStyles
        ]


css : List Snippet
css =
    globalStyles ++ componentStyles ++ HttpArchive.Views.css


layout : List (Html msg) -> Html msg
layout children =
    div [] children


queryStyles : Snippet
queryStyles =
    (.) Query
        [ Css.width (pct 60)
        , padding4 (Css.em 4) zero (Css.em 2) zero
        , Css.property "display" "table"
        , margin2 zero auto
        , children
            [ E.label
                [ display none
                ]
            , E.input
                [ Css.property "display" "table-cell"
                , Css.width (pct 100)
                , Css.height (Css.em 2)
                , padding (Css.em 0.5)
                , fontSize (pct 150)
                , border3 (px 1) solid (rgb 210 210 210)
                , boxShadow5 inset zero zero (px 2) (rgb 200 200 200)
                ]
            , E.span
                [ Css.property "display" "table-cell"
                , padding2 (Css.em 0) (Css.em 0.2)
                , children
                    [ E.button
                        [ Css.height (Css.em 2)
                        , fontSize (pct 150)
                        , color (hex "fff")
                        , fontWeight (int 300)
                        , backgroundColor (rgb 52 208 43)
                        , border3 (px 1) outset (rgb 52 208 43)
                        , padding2 (Css.em 0.2) (Css.em 1)
                        ]
                    ]
                ]
            ]
        ]


query : (String -> msg) -> msg -> Html msg
query queryChange submit =
    Html.form [ class [ Query ], onSubmit submit ]
        [ label [ for "query" ] [ Html.text "URL:" ]
        , input [ id "query", onInput queryChange ] []
        , span []
            [ button [ type_ "submit", onClick submit ] [ Html.text "Mark" ] ]
        ]


statusStyles : Snippet
statusStyles =
    (.) StatusText
        [ textAlign center
        , fontWeight (int 200)
        , fontSize (pct 140)
        , color (rgb 160 160 160)
        ]


output : Output -> Html msg
output output =
    case output of
        Status message ->
            p [ class [ StatusText ] ] [ Html.text message ]

        Archive l ->
            log l
