import Html exposing (div, button, text, input)
import Html.App as App
import Html.Events exposing (onClick, onInput)
import Task
import Http
import Json.Decode as Json


main =
  App.program { init = model, view = view, update = update, subscriptions = subscriptions }

type alias Model =
  { text : String
  , finalText : String
  }

model : (Model, Cmd a)
model =
  (Model "" "", Cmd.none)


view model =
  div []
    [ input [ onInput UpdateText ] []
    , button [ onClick GetMoreData ] [ text "Update" ]
    , div [] [ text (toString model.finalText) ]
    ]


type Msg = UpdateText String | UpdateFinalText String | GetMoreData | GetDataFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UpdateText text ->
      ({ model | text = text }, Cmd.none)

    UpdateFinalText finalText ->
      ({ model | finalText = finalText }, Cmd.none)

    GetMoreData ->
      (model, getData model.text)

    GetDataFail error ->
      ({ model | finalText = (toString error) }, Cmd.none)


getData : String -> Cmd Msg
getData url =
  let
    url =
      "http://localhost:3000/api?url=" ++ url
  in
    Task.perform GetDataFail UpdateFinalText (Http.get decodeResponse url)


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


decodeResponse : Json.Decoder String
decodeResponse =
  Json.at ["url"] Json.string
