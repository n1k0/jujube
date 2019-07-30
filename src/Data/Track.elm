module Data.Track exposing (Track, encode)

import Data.Sequence as Sequence exposing (Sequence)
import Json.Encode as Encode


type alias Track =
    { instrument : String
    , pan : Float
    , volume : Float
    , sequence : Sequence
    }


encode : Track -> Encode.Value
encode v =
    Encode.object
        [ ( "instrument", Encode.string v.instrument )
        , ( "pan", Encode.float v.pan )
        , ( "volume", Encode.float v.volume )
        , ( "sequence", Sequence.encode v.sequence )
        ]
