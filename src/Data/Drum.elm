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


randomSeq : (Note -> Float -> Sequence) -> Generator String -> Generator Track
randomSeq handler =
    Random.andThen
        (\note ->
            Random.map (Track note)
                (Random.float 0 1
                    |> Random.andThen (handler (Note note "16n" 1) >> Random.constant)
                )
        )


randomKick : Generator Track
randomKick =
    DrumKit.randomKick
        |> randomSeq
            (\hit prob ->
                if prob > 0.5 then
                    Multiple [ Single hit, Silence ]

                else
                    Multiple [ Single hit ]
            )


randomSnare : Generator Track
randomSnare =
    DrumKit.randomSnare
        |> randomSeq
            (\hit prob ->
                if prob < 0.5 then
                    Multiple [ Silence, Single hit ]

                else if prob < 0.75 then
                    Multiple
                        [ Silence
                        , Single hit
                        , Silence
                        , Single hit
                        , Silence
                        , Single hit
                        , Silence
                        , Multiple [ Single hit, Single hit ]
                        ]

                else
                    Multiple
                        [ Silence
                        , Single hit
                        , Silence
                        , Single hit
                        , Silence
                        , Single hit
                        , Silence
                        , Multiple [ Single hit, Multiple [ Single hit, Single hit ] ]
                        ]
            )


randomHihat : Generator Track
randomHihat =
    DrumKit.randomHihat
        |> randomSeq
            (\hit prob ->
                if prob > 0.7 then
                    Multiple [ Single hit, Single hit, Silence, Single hit ]

                else if prob > 0.5 then
                    Multiple [ Multiple [ Single hit, Single hit ] ]

                else
                    Multiple [ Single hit ]
            )
