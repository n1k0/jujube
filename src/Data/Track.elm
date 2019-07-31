module Data.Track exposing (Track, encode, random)

import Data.Instrument as Instrument exposing (Instrument)
import Data.Scale as Scale exposing (Scale)
import Data.Sequence as Sequence exposing (Sequence)
import Json.Encode as Encode
import Random exposing (Generator)
import Random.List as RandomList


type alias Track =
    { instrument : Instrument
    , pan : Float
    , volume : Float
    , resolution : String
    , sequence : Sequence
    }


encode : Track -> Encode.Value
encode v =
    Encode.object
        [ ( "instrument", Instrument.encode v.instrument )
        , ( "pan", Encode.float v.pan )
        , ( "volume", Encode.float v.volume )
        , ( "resolution", Encode.string v.resolution )
        , ( "sequence", Sequence.encode v.sequence )
        ]


random : Generator Track
random =
    Random.map5 Track
        Instrument.random
        (Random.float -1 1)
        (Random.float -20 -10)
        (Random.constant "4n")
        (Sequence.random (Scale.range 1 6 Scale.diat))
