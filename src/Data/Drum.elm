module Data.Drum exposing (Drum, encode, random)

import Data.Note as Note exposing (Note)
import Data.Sequence as Sequence exposing (Sequence(..))
import Json.Encode as Encode
import Random exposing (Generator)
import Random.List as RandomList


type alias Drum =
    { kick : Sequence
    , snare : Sequence
    , hihat : Sequence
    }


encode : Drum -> Encode.Value
encode v =
    Encode.object
        [ ( "kick", Sequence.encode v.kick )
        , ( "snare", Sequence.encode v.snare )
        , ( "hihat", Sequence.encode v.hihat )
        ]


randomKick : Generator Sequence
randomKick =
    Random.float
        |> Random.andThen
            (\prob ->
                if prob > 0.5 then
                    Random.constant (Multiple [ Single "kick", Silence ])

                else
                    Random.constant (Multiple [ Single "kick" ])
            )


randomSnare : Generator Sequence
randomSnare =
    Random.float
        |> Random.andThen
            (\prob ->
                if prob > 0.5 then
                    Random.constant (Multiple [ Silence, Single "snare" ])

                else
                    Random.constant (Multiple [ Single "snare" ])
            )


randomHihat : Generator Sequence
randomHihat =
    Random.float
        |> Random.andThen
            (\prob ->
                if prob > 0.8 then
                    Random.constant (Multiple [ Single "snare", Single "snare", Silence, Single "snare" ])

                else if prob > 0.4 then
                    Random.constant (Multiple [ Multiple [ Single "snare", Single "snare" ] ])

                else
                    Random.constant (Multiple [ Single "snare" ])
            )


random : Generator Drum
random =
    Random.map3 Drum
        randomKick
        randomSnare
        randomHihat
