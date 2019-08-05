module Data.Drum.Kit exposing
    ( randomClap
    , randomCrash
    , randomHihat
    , randomKick
    , randomOpenhat
    , randomPerc
    , randomRide
    , randomShaker
    , randomSnare
    , randomTom
    )

import Random exposing (Generator)
import Random.List as RandomList


pick : List String -> Generator String
pick =
    RandomList.choose
        >> Random.andThen
            (Tuple.first
                >> Maybe.withDefault ""
                >> Random.constant
            )


randomClap : Generator String
randomClap =
    pick
        [ "audio/clap-808.ogg"
        , "audio/clap-analog.ogg"
        , "audio/clap-crushed.ogg"
        , "audio/clap-fat.ogg"
        , "audio/clap-slapper.ogg"
        , "audio/clap-tape.ogg"
        ]


randomCrash : Generator String
randomCrash =
    pick
        [ "audio/crash-808.ogg"
        , "audio/crash-acoustic.ogg"
        , "audio/crash-noise.ogg"
        , "audio/crash-tape.ogg"
        ]


randomHihat : Generator String
randomHihat =
    pick
        [ "audio/hihat-808.ogg"
        , "audio/hihat-digital.ogg"
        , "audio/hihat-electro.ogg"
        , "audio/hihat-plain.ogg"
        ]


randomKick : Generator String
randomKick =
    pick
        [ "audio/kick-deep.ogg"
        , "audio/kick-electro01.ogg"
        , "audio/kick-floppy.ogg"
        , "audio/kick-newwave.ogg"
        , "audio/kick-oldschool.ogg"
        , "audio/kick-tape.ogg"
        , "audio/kick-tight.ogg"
        , "audio/kick-tron.ogg"
        ]


randomOpenhat : Generator String
randomOpenhat =
    pick
        [ "audio/openhat-808.ogg"
        , "audio/openhat-acoustic01.ogg"
        , "audio/openhat-analog.ogg"
        , "audio/openhat-slick.ogg"
        , "audio/openhat-tight.ogg"
        ]


randomPerc : Generator String
randomPerc =
    pick
        [ "audio/perc-808.ogg"
        , "audio/perc-chirpy.ogg"
        , "audio/perc-hollow.ogg"
        , "audio/perc-laser.ogg"
        , "audio/perc-metal.ogg"
        , "audio/perc-nasty.ogg"
        , "audio/perc-short.ogg"
        , "audio/perc-tambo.ogg"
        , "audio/perc-tribal.ogg"
        , "audio/perc-weirdo.ogg"
        ]


randomRide : Generator String
randomRide =
    pick
        [ "audio/ride-acoustic01.ogg"
        , "audio/ride-acoustic02.ogg"
        ]


randomShaker : Generator String
randomShaker =
    pick
        [ "audio/shaker-analog.ogg"
        , "audio/shaker-shuffle.ogg"
        , "audio/shaker-suckup.ogg"
        ]


randomSnare : Generator String
randomSnare =
    pick
        [ "audio/snare-electro.ogg"
        , "audio/snare-lofi01.ogg"
        , "audio/snare-noise.ogg"
        , "audio/snare-pinch.ogg"
        ]


randomTom : Generator String
randomTom =
    pick
        [ "audio/tom-808.ogg"
        , "audio/tom-acoustic01.ogg"
        , "audio/tom-acoustic02.ogg"
        , "audio/tom-analog.ogg"
        , "audio/tom-chiptune.ogg"
        , "audio/tom-fm.ogg"
        , "audio/tom-lofi.ogg"
        , "audio/tom-rototom.ogg"
        , "audio/tom-short.ogg"
        ]
