module Main exposing (main)

import Array exposing (Array)
import Browser
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


init : () -> ( Model, Cmd Msg )
init _ =
    ( { bpm = 120
      , playing = False
      , tracks = []
      }
    , Cmd.batch
        [ Random.int 80 100
            |> Random.generate SetBpm
        , Sequence.random (Scale.range 1 2 Scale.penta)
            |> Random.generate (Track "tiny" -0.5 -8 >> NewTrack)
        , Sequence.random (Scale.range 3 5 Scale.penta)
            |> Random.generate (Track "kalimba" 0.5 -12 >> NewTrack)
        , Sequence.random (Scale.range 5 6 Scale.penta)
            |> Random.generate (Track "steelpan" 0 -16 >> NewTrack)
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewTrack track ->
            ( { model | tracks = track :: model.tracks }
            , Cmd.none
            )

        Play ->
            ( { model | playing = True }
            , Cmd.batch
                [ model.tracks
                    |> List.map (Track.encode >> Ports.setTrack)
                    |> Cmd.batch
                , Ports.mute False
                ]
            )

        SetBpm bpm ->
            ( { model | bpm = bpm }, Ports.setBpm bpm )

        Stop ->
            ( { model | playing = False }, Ports.mute True )


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
            ]
        , model.tracks
            |> List.map
                (\{ sequence } ->
                    pre []
                        [ sequence
                            |> Sequence.encode
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
