module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (..)
import Ports
import Time exposing (Posix)


type alias Model =
    { beat : Int
    , bpm : Int
    , playing : Bool
    }


type Msg
    = Play
    | SetBpm Int
    | Stop
    | Tick Posix


init : () -> ( Model, Cmd Msg )
init _ =
    ( { beat = 1, bpm = 120, playing = False }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play ->
            ( { model | playing = True }, Ports.play () )

        SetBpm bpm ->
            ( { model | bpm = bpm }, Cmd.none )

        Stop ->
            ( { model | beat = 1, playing = False }, Cmd.none )

        Tick posix ->
            if model.playing then
                ( { model
                    | beat =
                        if model.beat == 16 then
                            1

                        else
                            model.beat + 1
                  }
                , Ports.play ()
                )

            else
                ( model, Cmd.none )


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
        , div [] [ text <| "beat: " ++ String.fromInt model.beat ]
        , div []
            [ if model.playing then
                button [ onClick Stop ] [ text "stop" ]

              else
                button [ onClick Play ] [ text "play" ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions { bpm, playing } =
    if playing then
        Time.every (60000 / toFloat bpm) Tick

    else
        Sub.none


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
