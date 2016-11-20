module Main exposing (..)

import Html
import Html.App as App
import Server as API
import Model exposing (Model, Output(..))
import Message exposing (Message(..))
import Components as UI


main =
    App.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : ( Model, Cmd a )
init =
    ( Model "" (Single "Ready."), Cmd.none )


update : Message -> Model -> ( Model, Cmd Message )
update msg { query, output } =
    case msg of
        ChangeQuery text ->
            ( Model text output, Cmd.none )

        Fetch ->
            ( Model query (Model.Single "Awaiting response..."), API.send query )

        Receive json ->
            case Model.fromJson json of
                Err err ->
                    ( Model query (Model.Single err), Cmd.none )

                Ok msgs ->
                    ( Model query (Model.Multiple msgs), Cmd.none )


subscriptions : Model -> Sub Message
subscriptions model =
    API.listen Receive


view : Model -> Html.Html Message
view model =
    UI.layout
        [ UI.query ChangeQuery Fetch
        , UI.output model.output
        ]
