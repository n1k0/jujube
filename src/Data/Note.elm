module Data.Note exposing (Note, encode, randomFromPitch)

import Json.Encode as Encode
import Random exposing (Generator)
import Random.List as RandomList


type alias Note =
    { pitch : String
    , dur : String
    , vel : Float
    }


durations : List String
durations =
    [ "8n", "12n", "16n", "32n" ]


encode : Note -> Encode.Value
encode v =
    Encode.object
        [ ( "dur", Encode.string v.dur )
        , ( "vel", Encode.float v.vel )
        , ( "pitch", Encode.string v.pitch )
        ]


randomFromPitch : String -> Generator Note
randomFromPitch pitch =
    Random.map2 (Note pitch)
        (RandomList.choose durations |> Random.andThen (Tuple.first >> Maybe.withDefault "16n" >> Random.constant))
        (Random.float 0.2 1)
