import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Task exposing (Task)
import Http
import Json.Decode as Json

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = (always Sub.none)
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

fetchCmd : String -> Cmd Msg
fetchCmd url =
  let
    data : String -> Task Http.Error String
    data url =
      Http.get decode ("http://localhost:3000/api?url=" ++ url)
  in
    Task.perform FetchError FetchSuccess (data url)

decode : Json.Decoder String
decode =
  Json.at ["url"] Json.string

type Msg
  = ChangeQuery String
  | Fetch
  | FetchSuccess String
  | FetchError Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeQuery text ->
      ({ model | query = text }, Cmd.none)

    Fetch ->
      ({ model | output = "Fetching..." }, fetchCmd model.query)

    FetchSuccess output ->
      ({ model | output = "Server responded: " ++ output }, Cmd.none)

    FetchError error ->
      ({ model | output = (toString error) }, Cmd.none)


-- View

view : Model -> Html Msg
view model =
  div []
    [ input [ onInput ChangeQuery ] []
    , button [ onClick Fetch ] [ text "Update" ]
    , p [] [ text (toString model.output) ]
    ]
