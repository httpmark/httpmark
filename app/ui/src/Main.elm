import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import WebSocket
import Json.Decode as Decode

webSocketUrl = "ws://localhost:3000/stream"

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Model

type Output
  = ServerMessages (List String)
  | Message String

type alias Model =
  { query : String
  , output : Output
  }

init : (Model, Cmd a)
init =
  (Model "" (Message ""), Cmd.none)

-- Update

sendCmd : String -> Cmd Msg
sendCmd input =
  WebSocket.send webSocketUrl input

decodeMessage : String -> Result String (List String)
decodeMessage message =
  let
    messageDecoder =
      Decode.at ["messages"] (Decode.list Decode.string)
  in
    Decode.decodeString messageDecoder message

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
      (Model query (Message "Awaiting response..."), sendCmd query)

    Receive text ->
      case decodeMessage text of
        Err err ->
          (Model query (Message err), Cmd.none)

        Ok msgs ->
          (Model query (ServerMessages msgs), Cmd.none)

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
    , messages model.output
    ]

messages : Output -> Html Msg
messages output =
  case output of
    Message message ->
      p [] [ text message ]

    ServerMessages messages ->
      ul [] (List.map (\l -> li [] [ text l ]) messages)
