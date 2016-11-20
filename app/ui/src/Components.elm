module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)

import Model exposing (Output(..))

layout : List (Html msg) -> Html msg
layout children =
  div [] children

query : (String -> msg) -> msg -> Html msg
query queryChange submit =
  Html.form [ onSubmit submit ]
   [ label [ for "query" ] [ text "Your query: " ]
   , input [ id "query", onInput queryChange ] []
   , button [ type' "submit", onClick submit ] [ text "Update" ]
   ]

output : Output -> Html msg
output output =
  case output of
    Single message ->
      p [] [ text message ]

    Multiple messages ->
      div []
        [ p [] [ text "Server messages:" ]
        , ul [] (List.map (\l -> li [] [ text l ]) messages)
        ]
