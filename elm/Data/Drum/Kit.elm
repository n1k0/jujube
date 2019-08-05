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
        [ "clap-808.ogg"
        , "clap-analog.ogg"
        , "clap-crushed.ogg"
        , "clap-fat.ogg"
        , "clap-slapper.ogg"
        , "clap-tape.ogg"
        ]


randomCrash : Generator String
randomCrash =
    pick
        [ "crash-808.ogg"
        , "crash-acoustic.ogg"
        , "crash-noise.ogg"
        , "crash-tape.ogg"
        ]


randomHihat : Generator String
randomHihat =
    pick
        [ "hihat-808.ogg"
        , "hihat-digital.ogg"
        , "hihat-electro.ogg"
        , "hihat-plain.ogg"
        ]


randomKick : Generator String
randomKick =
    pick
        [ "kick-deep.ogg"
        , "kick-electro01.ogg"
        , "kick-floppy.ogg"
        , "kick-newwave.ogg"
        , "kick-oldschool.ogg"
        , "kick-tape.ogg"
        , "kick-tight.ogg"
        , "kick-tron.ogg"
        ]


randomOpenhat : Generator String
randomOpenhat =
    pick
        [ "openhat-808.ogg"
        , "openhat-acoustic01.ogg"
        , "openhat-analog.ogg"
        , "openhat-slick.ogg"
        , "openhat-tight.ogg"
        ]


randomPerc : Generator String
randomPerc =
    pick
        [ "perc-808.ogg"
        , "perc-chirpy.ogg"
        , "perc-hollow.ogg"
        , "perc-laser.ogg"
        , "perc-metal.ogg"
        , "perc-nasty.ogg"
        , "perc-short.ogg"
        , "perc-tambo.ogg"
        , "perc-tribal.ogg"
        , "perc-weirdo.ogg"
        ]


randomRide : Generator String
randomRide =
    pick
        [ "ride-acoustic01.ogg"
        , "ride-acoustic02.ogg"
        ]


randomShaker : Generator String
randomShaker =
    pick
        [ "shaker-analog.ogg"
        , "shaker-shuffle.ogg"
        , "shaker-suckup.ogg"
        ]


randomSnare : Generator String
randomSnare =
    pick
        [ "snare-electro.ogg"
        , "snare-lofi01.ogg"
        , "snare-noise.ogg"
        , "snare-pinch.ogg"
        ]


randomTom : Generator String
randomTom =
    pick
        [ "tom-808.ogg"
        , "tom-acoustic01.ogg"
        , "tom-acoustic02.ogg"
        , "tom-analog.ogg"
        , "tom-chiptune.ogg"
        , "tom-fm.ogg"
        , "tom-lofi.ogg"
        , "tom-rototom.ogg"
        , "tom-short.ogg"
        ]
