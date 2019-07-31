module Data.Drum exposing (Drum, encode, randomHihat, randomKick, randomSnare)

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


hit : Note
hit =
    Note "hit" "16n" 1


randomKick : Generator Sequence
randomKick =
    Random.float 0 1
        |> Random.andThen
            (\prob ->
                if prob > 0.5 then
                    Random.constant (Multiple [ Single hit, Silence ])

                else
                    Random.constant (Multiple [ Single hit ])
            )


randomSnare : Generator Sequence
randomSnare =
    Random.float 0 1
        |> Random.andThen
            (\prob ->
                if prob < 0.3 then
                    Random.constant (Multiple [ Silence, Single hit ])

                else if prob < 0.6 then
                    Random.constant (Multiple [ Multiple [ Single hit, Single hit ] ])

                else
                    Random.constant (Multiple [ Single hit ])
            )


randomHihat : Generator Sequence
randomHihat =
    Random.float 0 1
        |> Random.andThen
            (\prob ->
                if prob > 0.8 then
                    Random.constant (Multiple [ Single hit, Single hit, Silence, Single hit ])

                else if prob > 0.4 then
                    Random.constant (Multiple [ Multiple [ Single hit, Single hit ] ])

                else
                    Random.constant (Multiple [ Single hit ])
            )
