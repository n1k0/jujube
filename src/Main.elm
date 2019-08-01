module Main exposing (main)

import Array exposing (Array)
import Browser
import Data.Drum as Drum exposing (Drum)
import Data.Instrument as Instrument exposing (Instrument)
import Data.Scale as Scale
import Data.Sequence as Sequence exposing (Sequence(..))
import Data.Track as Track exposing (Track)
import Html exposing (..)
import Html.Attributes as HA exposing (..)
import Html.Events exposing (..)
import Json.Encode as Encode
import Ports
import Random exposing (Generator)
import Random.Array as RandomArray
import Random.List as RandomList
import Time exposing (Posix)


type alias Model =
    { bpm : Int
    , status : Status
    , tracks : List Track
    }


type Status
    = Idle
    | Loading
    | Ready
    | Playing


type Msg
    = NewDrumTracks Drum
    | NewTrack Track
    | Play
    | SetReady Bool
    | SetBpm Int
    | Stop
    | Vary


init : () -> ( Model, Cmd Msg )
init _ =
    ( { bpm = 120
      , status = Idle
      , tracks = []
      }
    , Random.int 80 100 |> Random.generate SetBpm
    )


generate : List String -> Cmd Msg
generate scale =
    Cmd.batch
        [ Drum.random
            |> Random.generate NewDrumTracks
        , Track.random
            { id = "low"
            , bars = Just 4
            , instrument = Just Instrument.Piano
            , octaves = Just ( 2, 2 )
            , pan = Just 0
            , probability = Just 0.95
            , scale = scale
            , volume = Just -8
            }
            |> Random.generate NewTrack
        , Track.random
            { id = "mid"
            , bars = Just 6
            , instrument = Just Instrument.Cello
            , octaves = Just ( 3, 3 )
            , pan = Just -0.2
            , probability = Just 0.9
            , scale = scale
            , volume = Just -14
            }
            |> Random.generate NewTrack
        , Track.random
            { id = "high"
            , bars = Just 8
            , instrument = Just Instrument.Marimba
            , octaves = Just ( 4, 4 )
            , pan = Just 0.2
            , probability = Just 0.8
            , scale = scale
            , volume = Just -12
            }
            |> Random.generate NewTrack
        , Track.random
            { id = "other"
            , bars = Just 12
            , instrument = Just Instrument.Kalimba
            , octaves = Just ( 5, 5 )
            , pan = Just 0.4
            , probability = Just 0.7
            , scale = scale
            , volume = Just -16
            }
            |> Random.generate NewTrack
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewDrumTracks drumTracks ->
            ( model, drumTracks |> Drum.encode |> Ports.setDrumTracks )

        NewTrack track ->
            ( { model
                | tracks =
                    model.tracks
                        |> List.filter (.id >> (/=) track.id)
                        |> (::) track
              }
            , track |> Track.encode |> Ports.setTrack
            )

        Play ->
            case model.status of
                Idle ->
                    ( { model | status = Loading }, Ports.load () )

                Ready ->
                    ( { model | status = Playing }, Ports.start () )

                _ ->
                    ( model, Cmd.none )

        SetReady _ ->
            ( { model | status = Playing }
            , Cmd.batch
                [ generate Scale.first
                , Ports.start ()
                ]
            )

        SetBpm bpm ->
            ( { model | bpm = bpm }, Ports.setBpm bpm )

        Stop ->
            ( { model | status = Ready }, Ports.stop () )

        Vary ->
            ( { model | tracks = [] }, generate Scale.second )


viewTrack : Track -> Html Msg
viewTrack track =
    let
        viewSequence seq =
            case seq of
                Silence ->
                    li [] [ text "silence" ]

                Single { pitch } ->
                    li [] [ text pitch ]

                Multiple subSeq ->
                    subSeq |> List.map viewSequence |> ul []
    in
    div [ style "float" "left" ]
        [ div [] [ text track.id ]
        , div [] [ track.instrument |> Instrument.toString |> text ]
        , div [] [ text (String.fromFloat track.pan) ]
        , div [] [ text (String.fromFloat track.volume) ]
        , div [] [ viewSequence track.sequence ]
        ]


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
            [ case model.status of
                Idle ->
                    button [ onClick Play ] [ text "▶" ]

                Loading ->
                    button [ disabled True ] [ text "▶" ]

                Ready ->
                    button [ onClick Play ] [ text "▶" ]

                Playing ->
                    span []
                        [ button [ onClick Stop ] [ text "◼" ]
                        , button [ onClick Vary ] [ text "vary" ]
                        ]
            ]
        , model.tracks
            |> List.map viewTrack
            |> div []
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Ports.ready SetReady


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
