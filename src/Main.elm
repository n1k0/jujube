module Main exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (..)
import Json.Encode as Encode
import Ports
import Random
import Random.Array as RandomArray
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
    , volume : Float
    , sequence : Sequence
    }


type Msg
    = NewTrack Track
    | Pause
    | Play
    | SetBpm Int
    | Stop


init : () -> ( Model, Cmd Msg )
init _ =
    ( { bpm = 120
      , status = Stopped
      , tracks = []
      }
    , Cmd.batch
        [ Ports.setBpm 120
        , Random.float 0 1
            |> Random.andThen
                (\r ->
                    Random.constant
                        (if r > 0.5 then
                            Single "C3"

                         else
                            Multiple [ Single "Bb2", Single "Eb3" ]
                        )
                )
            |> RandomArray.rangeLengthArray 4 8
            |> Random.generate
                (\seq ->
                    NewTrack
                        { pan = 0.0
                        , volume = 0.0
                        , sequence = seq |> Array.toList |> Multiple
                        }
                )
        ]
    )


penta : List String
penta =
    let
        notes =
            [ "C", "Eb", "F", "F#", "G", "Bb" ]
    in
    List.range 3 4
        |> List.map (\oct -> notes |> List.map (\n -> n ++ String.fromInt oct))
        |> List.concat


bassSequence : Sequence
bassSequence =
    -- penta
    --     |> List.map Single
    --     |> Multiple
    Multiple
        [ Single "C3"
        , Multiple [ Single "Bb2", Single "C3", Single "Eb3" ]
        , Single "Bb2"
        , Multiple [ Single "Bb2", Single "Eb3" ]
        ]


encodeSequence : Sequence -> Encode.Value
encodeSequence seq =
    case seq of
        Single note ->
            Encode.string note

        Multiple subSeq ->
            Encode.list encodeSequence subSeq


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTrack track ->
            ( { model | tracks = track :: model.tracks }
            , Ports.setSequence (encodeSequence track.sequence)
            )

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
                    , HA.min "70"
                    , HA.max "160"
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
        , model.tracks
            |> List.map
                (\{ sequence } ->
                    pre []
                        [ sequence
                            |> encodeSequence
                            |> Encode.encode 2
                            |> text
                        ]
                )
            |> div []
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }
