port module Main exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (..)
import Time exposing (Posix)


type alias Model =
    { beat : Int
    , bpm : Int
    , playing : Bool
    }


type alias Note =
    { pitch : String
    , duration : String
    , velocity : Float
    }


type Msg
    = Play
    | SetBpm Int
    | Stop
    | Tick Posix


nBeats : Int
nBeats =
    4


seq : Array Note
seq =
    Array.fromList
        [ Note "C4" "8n" 1
        , Note "D4" "8n" 0.5
        , Note "E4" "16n" 1.1
        , Note "G4" "8n" 0.2
        ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( { beat = 0, bpm = 120, playing = False }, Cmd.none )


playBeat : Int -> Array Note -> Cmd Msg
playBeat beat =
    Array.get beat >> Maybe.map tonePlayNote >> Maybe.withDefault Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play ->
            ( { model | playing = True }, playBeat 0 seq )

        SetBpm bpm ->
            ( { model | bpm = bpm }, Cmd.none )

        Stop ->
            ( { model | beat = 0, playing = False }, Cmd.none )

        Tick posix ->
            if model.playing then
                let
                    newBeat =
                        if model.beat == nBeats - 1 then
                            0

                        else
                            model.beat + 1
                in
                ( { model | beat = newBeat }
                , playBeat newBeat seq
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
        , div [] [ text <| "beat: " ++ String.fromInt (model.beat + 1) ]
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



-- Ports


port tonePlayNote : Note -> Cmd msg
