port module Main exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (..)
import Time exposing (Posix)


type alias Model =
    { beat : Int
    , beats : Int
    , bpm : Int
    , playing : Bool
    }


type alias Note =
    { pitch : String
    , duration : String
    , velocity : Float
    }


type Msg
    = Pause
    | Play
    | SetBeats Int
    | SetBpm Int
    | Stop
    | Tick Posix


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
    ( { beat = 0
      , beats = 4
      , bpm = 120
      , playing = False
      }
    , Cmd.none
    )


playBeat : Int -> Array Note -> Cmd Msg
playBeat beat =
    Array.get beat >> Maybe.map tonePlayNote >> Maybe.withDefault Cmd.none


cycleBeat : Model -> Int
cycleBeat { beat, beats } =
    if beat == beats - 1 then
        0

    else
        beat + 1


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play ->
            ( { model | playing = True }, playBeat model.beat seq )

        SetBeats beats ->
            ( { model | beats = beats }, Cmd.none )

        SetBpm bpm ->
            ( { model | bpm = bpm }, Cmd.none )

        Pause ->
            ( { model | beat = cycleBeat model, playing = False }, Cmd.none )

        Stop ->
            ( { model | beat = 0, playing = False }, Cmd.none )

        Tick posix ->
            if model.playing then
                let
                    newBeat =
                        cycleBeat model
                in
                ( { model | beat = newBeat }
                , playBeat newBeat seq
                )

            else
                ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ label []
                [ text "BPM"
                , input
                    [ type_ "range"
                    , HA.min "40"
                    , HA.max "220"
                    , value <| String.fromInt model.bpm
                    , onInput (String.toInt >> Maybe.withDefault 120 >> SetBpm)
                    ]
                    []
                , text (String.fromInt model.bpm)
                ]
            ]
        , div []
            [ label []
                [ text "Beats"
                , input
                    [ type_ "range"
                    , HA.min "4"
                    , HA.max "64"
                    , step "4"
                    , value <| String.fromInt model.beats
                    , onInput (String.toInt >> Maybe.withDefault 16 >> SetBeats)
                    ]
                    []
                , text (String.fromInt model.beats)
                ]
            ]
        , div [] [ text <| "Current beat: " ++ String.fromInt (model.beat + 1) ]
        , div []
            [ button [ onClick Stop, disabled model.playing ] [ text "stop" ]
            , button [ onClick Pause, disabled (not model.playing) ] [ text "pause" ]
            , button [ onClick Play, disabled model.playing ] [ text "play" ]
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
