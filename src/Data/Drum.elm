module Data.Drum exposing (Drum, encode, random)

import Data.Drum.Kit as DrumKit
import Data.Note as Note exposing (Note)
import Data.Sequence as Sequence exposing (Sequence(..))
import Json.Encode as Encode
import Random exposing (Generator)
import Random.List as RandomList


type alias Drum =
    { kick : Track
    , snare : Track
    , hihat : Track
    }


type alias Track =
    { sample : String
    , sequence : Sequence
    }


encode : Drum -> Encode.Value
encode v =
    Encode.object
        [ ( "kick", encodeTrack v.kick )
        , ( "snare", encodeTrack v.snare )
        , ( "hihat", encodeTrack v.hihat )
        ]


encodeTrack : Track -> Encode.Value
encodeTrack v =
    Encode.object
        [ ( "sample", Encode.string v.sample )
        , ( "sequence", Sequence.encode v.sequence )
        ]


random : Generator Drum
random =
    Random.map3 Drum
        randomKick
        randomSnare
        randomHihat


randomSeq : (Sequence -> Float -> Sequence) -> Generator String -> Generator Track
randomSeq handler =
    Random.andThen
        (\note ->
            Random.map (Track note)
                (Random.float 0 1
                    |> Random.andThen (handler (Single (Note note "16n" 1)) >> Random.constant)
                )
        )


m : List Sequence -> Sequence
m =
    Multiple


x : Sequence
x =
    Silence


randomKick : Generator Track
randomKick =
    DrumKit.randomKick
        |> randomSeq
            (\h prob ->
                if prob < 0.2 then
                    m [ h, x ]

                else if prob < 0.4 then
                    m
                        [ m [ h, x, x, h ]
                        , m [ x, x, h, x ]
                        , m [ h, x, x, x ]
                        , x
                        ]

                else if prob < 0.6 then
                    m
                        [ m [ h, x, x, x ]
                        , m [ x, x, x, h ]
                        , m [ x, x, h, x ]
                        , x
                        ]

                else if prob < 0.8 then
                    m
                        [ m [ h, h, h ]
                        , x
                        , h
                        , x
                        ]

                else
                    m [ h ]
            )


randomSnare : Generator Track
randomSnare =
    DrumKit.randomSnare
        |> randomSeq
            (\h prob ->
                if prob < 0.5 then
                    m [ x, h ]

                else if prob < 0.75 then
                    m [ x, h, x, h, x, h, x, m [ h, h ] ]

                else if prob < 0.75 then
                    m [ x, h, x, h, x, h, x, m [ h, m [ h, h ] ] ]

                else
                    m [ x, h, x, h, x, h, x, m [ h, m [ h, h, x, h ] ] ]
            )


randomHihat : Generator Track
randomHihat =
    DrumKit.randomHihat
        |> randomSeq
            (\h prob ->
                if prob > 0.7 then
                    m [ h, h, x, h ]

                else if prob > 0.5 then
                    m [ m [ h, h ] ]

                else
                    m [ h ]
            )
