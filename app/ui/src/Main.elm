import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import WebSocket

webSocketUrl = "ws://localhost:3000/stream"

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Model

type alias Model =
  { query : String
  , output : String
  }

init : (Model, Cmd a)
init =
  (Model "" "", Cmd.none)

-- Update

sendCmd : String -> Cmd Msg
sendCmd input =
  WebSocket.send webSocketUrl input

type Msg
  = ChangeQuery String
  | Fetch
  | Receive String

update : Msg -> Model -> (Model, Cmd Msg)
update msg {query, output} =
  case msg of
    ChangeQuery text ->
      (Model text output, Cmd.none)

    Fetch ->
      (Model query "Awaiting response...", sendCmd query)

    Receive text ->
      (Model query ("Server sent: " ++ text), Cmd.none)

-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen webSocketUrl Receive

-- View

view : Model -> Html Msg
view model =
  div []
    [ input [ onInput ChangeQuery ] []
    , button [ onClick Fetch ] [ text "Update" ]
    , p [] [ text (toString model.output) ]
    ]
