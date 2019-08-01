module Main exposing (main)

-- import Data.Drum as Drum exposing (Drum)

import Array exposing (Array)
import Browser
import Data.Instrument as Instrument exposing (Instrument)
import Data.Scale as Scale exposing (Scale)
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
    , playing : Bool
    , tracks : List Track
    }


type Msg
    = NewTrack Track
    | Play
    | SetBpm Int
    | Stop
    | Vary


init : () -> ( Model, Cmd Msg )
init _ =
    ( { bpm = 120
      , playing = False
      , tracks = []
      }
    , Random.int 80 100 |> Random.generate SetBpm
    )


generate : List String -> Cmd Msg
generate scale =
    Cmd.batch
        [ Track.random
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
            ( { model | playing = True }
            , Cmd.batch
                [ generate Scale.min7
                , Ports.start ()
                ]
            )

        SetBpm bpm ->
            ( { model | bpm = bpm }, Ports.setBpm bpm )

        Stop ->
            ( { model | playing = False }, Ports.stop () )

        Vary ->
            ( { model | tracks = [] }, generate Scale.maj7 )


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
            [ if model.playing then
                button [ onClick Stop ] [ text "◼" ]

              else
                button [ onClick Play ] [ text "▶" ]
            , button [ onClick Vary ] [ text "vary" ]
            ]
        , model.tracks
            |> List.map viewTrack
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
