module Main exposing (..)

import Html
import Server as API
import Model exposing (Model, Output(..), updateFromResponse)
import Message exposing (Message(..))
import Components as UI
import HttpArchive exposing (fromJson)


main : Program Never Model Message
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : ( Model, Cmd a )
init =
    ( Model "" (Status ""), Cmd.none )


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        ChangeQuery text ->
            ( { model | query = text }, Cmd.none )

        Fetch ->
            ( { model | output = Model.Status "Loading..." }, API.send model.query )

        Receive json ->
            ( Model.updateFromResponse (fromJson json) model, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions model =
    API.listen Receive


view : Model -> Html.Html Message
view model =
    UI.layout
        [ UI.query ChangeQuery Fetch
        , UI.output model.output
        ]
