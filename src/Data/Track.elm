module Data.Track exposing (Track, encode, random)

import Data.Drum as Drum exposing (Drum)
import Data.Instrument as Instrument exposing (Instrument)
import Data.Scale as Scale exposing (Scale)
import Data.Sequence as Sequence exposing (Sequence)
import Json.Encode as Encode
import Random exposing (Generator)
import Random.List as RandomList


type alias Track =
    { id : String
    , instrument : Instrument
    , pan : Float
    , volume : Float
    , resolution : String
    , sequence : Sequence
    }


type alias Config =
    { id : String
    , bars : Maybe Int
    , instrument : Maybe Instrument
    , octaves : Maybe ( Int, Int )
    , pan : Maybe Float
    , scale : List String
    , volume : Maybe Float
    }


encode : Track -> Encode.Value
encode v =
    Encode.object
        [ ( "id", Encode.string v.id )
        , ( "instrument", Instrument.encode v.instrument )
        , ( "pan", Encode.float v.pan )
        , ( "volume", Encode.float v.volume )
        , ( "resolution", Encode.string v.resolution )
        , ( "sequence", Sequence.encode v.sequence )
        ]


random : Config -> Generator Track
random config =
    Random.map5 (Track config.id)
        (config.instrument |> Maybe.map Random.constant >> Maybe.withDefault Instrument.random)
        (config.pan |> Maybe.map Random.constant |> Maybe.withDefault (Random.float -1 1))
        (config.volume |> Maybe.map Random.constant |> Maybe.withDefault (Random.float -20 -10))
        (Random.constant "4n")
        (Sequence.random (config.bars |> Maybe.withDefault 4) (Scale.range (config.octaves |> Maybe.withDefault ( 1, 6 )) config.scale))
