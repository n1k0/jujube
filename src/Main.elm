module Main exposing (main)

import Array exposing (Array)
import Browser
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



-- type alias Note =
--     { pitch : String
--     , velocity : Float
--     }


type Sequence
    = Silence
    | Single String
    | Multiple (List Sequence)


type alias Track =
    { instrument : String
    , pan : Float
    , volume : Float
    , sequence : Sequence
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
        , randomSequence
            |> Random.generate
                (\seq ->
                    NewTrack
                        { instrument = "tiny"
                        , pan = 0
                        , volume = 0
                        , sequence = seq
                        }
                )
        ]
    )


pickOne : List String -> Generator Sequence
pickOne =
    RandomList.choose
        >> Random.andThen
            (Tuple.first
                >> Maybe.map Single
                >> Maybe.withDefault Silence
                >> Random.constant
            )


pickMany : Int -> List String -> Generator Sequence
pickMany length =
    pickOne
        >> RandomArray.array length
        >> Random.andThen (Array.toList >> Multiple >> Random.constant)


decideWhat : Float -> Generator Sequence
decideWhat prob =
    if prob > 0.95 then
        penta |> scale 2 4 |> pickMany 3

    else if prob > 0.9 then
        Random.constant Silence

    else if prob > 0.8 then
        penta |> scale 2 4 |> pickOne

    else if prob > 0.4 then
        penta |> scale 2 4 |> pickMany 2

    else
        penta |> scale 2 4 |> pickMany 4


randomSequence : Generator Sequence
randomSequence =
    Random.float 0 1
        |> Random.andThen decideWhat
        |> RandomArray.rangeLengthArray 4 8
        |> Random.andThen (Array.toList >> Multiple >> Random.constant)


min7 : List String
min7 =
    [ "C", "Eb", "G", "Bb" ]


maj7 : List String
maj7 =
    [ "C", "E", "G", "B" ]


penta : List String
penta =
    [ "A", "C", "D", "E", "F", "G" ]


scale : Int -> Int -> List String -> List String
scale minOctave maxOctave notes =
    List.range minOctave maxOctave
        |> List.map (\oct -> notes |> List.map (\n -> n ++ String.fromInt oct))
        |> List.concat


encodeSequence : Sequence -> Encode.Value
encodeSequence seq =
    case seq of
        Silence ->
            Encode.list Encode.string []

        Single note ->
            Encode.string note

        Multiple subSeq ->
            Encode.list encodeSequence subSeq


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
                    |> List.map (\{ instrument, sequence } -> Ports.setSequence ( instrument, encodeSequence sequence ))
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
