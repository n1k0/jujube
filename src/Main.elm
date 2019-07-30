module Main exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (..)
import Json.Encode as Encode
import Ports
import Time exposing (Posix)


type alias Model =
    { bpm : Int
    , status : Status
    , tracks : List Track
    }


type Status
    = Paused
    | Playing
    | Stopped



-- type alias Note =
--     { pitch : String
--     , velocity : Float
--     }


type Sequence
    = Single String
    | Multiple (List Sequence)


type alias Track =
    { pan : Float
    , sequence : Sequence
    , volume : Float
    }


type Msg
    = Pause
    | Play
    | SetBpm Int
    | Stop


bassSequence : Sequence
bassSequence =
    Multiple
        [ Single "C3"
        , Multiple [ Single "B2", Single "Eb3" ]
        , Single "B2"
        , Multiple [ Single "B2", Single "C3", Single "Eb3" ]
        ]


encodeSequence : Sequence -> Encode.Value
encodeSequence seq =
    case seq of
        Single note ->
            Encode.string note

        Multiple subSeq ->
            Encode.list encodeSequence subSeq


init : () -> ( Model, Cmd Msg )
init _ =
    ( { bpm = 120
      , status = Stopped
      , tracks =
            [ { pan = 1, volume = 1, sequence = bassSequence }
            ]
      }
    , Cmd.batch
        [ Ports.setBpm 120
        , Ports.setSequence (encodeSequence bassSequence)
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Pause ->
            ( { model | status = Paused }, Ports.pauseTransport () )

        Play ->
            ( { model | status = Playing }, Ports.startTransport () )

        SetBpm bpm ->
            ( { model | bpm = bpm }, Ports.setBpm bpm )

        Stop ->
            ( { model | status = Stopped }, Ports.stopTransport () )


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
            [ button [ onClick Stop, disabled (model.status == Stopped) ] [ text "◼" ]
            , case model.status of
                Playing ->
                    button [ onClick Pause ] [ text "▮▮" ]

                _ ->
                    button [ onClick Play ] [ text "▶" ]
            ]
        , pre []
            [ bassSequence
                |> encodeSequence
                |> Encode.encode 2
                |> text
            ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
