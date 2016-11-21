module Main exposing (..)

import Html
import Server as API
import Model exposing (Model, Output(..))
import Message exposing (Message(..))
import Components as UI


main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : ( Model, Cmd a )
init =
    ( Model "" (Status "Ready."), Cmd.none )


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        ChangeQuery text ->
            ( { model | query = text }, Cmd.none )

        Fetch ->
            ( { model | output = Model.Status "Awaiting response..." }, API.send model.query )

        Receive json ->
            case Model.fromJson json of
                Err err ->
                    ( { model | output = Model.Status err }, Cmd.none )

                Ok msgs ->
                    ( { model | output = Model.Messages msgs }, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions model =
    API.listen Receive


view : Model -> Html.Html Message
view model =
    UI.layout
        [ UI.query ChangeQuery Fetch
        , UI.output model.output
        ]
