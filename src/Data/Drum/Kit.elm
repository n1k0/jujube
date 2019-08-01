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
        , "audio/hihat-acoustic01.ogg"
        , "audio/hihat-acoustic02.ogg"
        , "audio/hihat-analog.ogg"
        , "audio/hihat-digital.ogg"
        , "audio/hihat-dist01.ogg"
        , "audio/hihat-dist02.ogg"
        , "audio/hihat-electro.ogg"
        , "audio/hihat-plain.ogg"
        , "audio/hihat-reso.ogg"
        , "audio/hihat-ring.ogg"
        ]


randomKick : Generator String
randomKick =
    pick
        [ "audio/kick-808.ogg"
        , "audio/kick-acoustic01.ogg"
        , "audio/kick-acoustic02.ogg"
        , "audio/kick-big.ogg"
        , "audio/kick-classic.ogg"
        , "audio/kick-cultivator.ogg"
        , "audio/kick-deep.ogg"
        , "audio/kick-dry.ogg"
        , "audio/kick-electro01.ogg"
        , "audio/kick-electro02.ogg"
        , "audio/kick-floppy.ogg"
        , "audio/kick-gritty.ogg"
        , "audio/kick-heavy.ogg"
        , "audio/kick-newwave.ogg"
        , "audio/kick-oldschool.ogg"
        , "audio/kick-plain.ogg"
        , "audio/kick-slapback.ogg"
        , "audio/kick-softy.ogg"
        , "audio/kick-stomp.ogg"
        , "audio/kick-tape.ogg"
        , "audio/kick-thump.ogg"
        , "audio/kick-tight.ogg"
        , "audio/kick-tron.ogg"
        , "audio/kick-vinyl01.ogg"
        , "audio/kick-vinyl02.ogg"
        , "audio/kick-zapper.ogg"
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
        [ "audio/snare-808.ogg"
        , "audio/snare-acoustic01.ogg"
        , "audio/snare-acoustic02.ogg"
        , "audio/snare-analog.ogg"
        , "audio/snare-big.ogg"
        , "audio/snare-block.ogg"
        , "audio/snare-brute.ogg"
        , "audio/snare-dist01.ogg"
        , "audio/snare-dist02.ogg"
        , "audio/snare-dist03.ogg"
        , "audio/snare-electro.ogg"
        , "audio/snare-lofi01.ogg"
        , "audio/snare-lofi02.ogg"
        , "audio/snare-modular.ogg"
        , "audio/snare-noise.ogg"
        , "audio/snare-pinch.ogg"
        , "audio/snare-punch.ogg"
        , "audio/snare-smasher.ogg"
        , "audio/snare-sumo.ogg"
        , "audio/snare-tape.ogg"
        , "audio/snare-vinyl01.ogg"
        , "audio/snare-vinyl02.ogg"
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
