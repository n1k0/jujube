module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (..)
import Ports
import Time exposing (Posix)


type alias Model =
    { bpm : Int
    , playing : Bool
    }


type Msg
    = Play
    | SetBpm Int
    | Stop
    | Tick Posix


init : () -> ( Model, Cmd Msg )
init _ =
    ( { bpm = 120, playing = False }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play ->
            ( { model | playing = True }, Cmd.none )

        SetBpm bpm ->
            ( { model | bpm = bpm }, Cmd.none )

        Stop ->
            ( { model | playing = False }, Cmd.none )

        Tick posix ->
            ( model
            , if model.playing then
                Ports.play ()

              else
                Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ input
            [ type_ "range"
            , HA.min "40"
            , HA.max "220"
            , value <| String.fromInt model.bpm
            , onInput (String.toInt >> Maybe.withDefault 120 >> SetBpm)
            ]
            []
        , text (String.fromInt model.bpm)
        , div []
            [ if model.playing then
                button [ onClick Stop ] [ text "stop" ]

              else
                button [ onClick Play ] [ text "play" ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions { bpm } =
    Time.every (60000 / toFloat bpm) Tick


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
