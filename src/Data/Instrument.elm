module Data.Instrument exposing (Instrument(..), encode, random)

import Json.Encode as Encode
import Random exposing (Generator)
import Random.List as RandomList


type Instrument
    = Bass
    | Brass
    | Cello
    | HiHat
    | Kalimba
    | Kick
    | Marimba
    | Piano
    | Snare
    | Steelpan
    | Wind


encode : Instrument -> Encode.Value
encode =
    toString >> Encode.string


tonal : List Instrument
tonal =
    [ Bass, Brass, Cello, Kalimba, Marimba, Piano, Steelpan, Wind ]


random : Generator Instrument
random =
    RandomList.choose tonal
        |> Random.andThen (Tuple.first >> Maybe.withDefault Piano >> Random.constant)


toString : Instrument -> String
toString instrument =
    case instrument of
        Bass ->
            "bass"

        Brass ->
            "brass"

        Cello ->
            "cello"

        Kalimba ->
            "kalimba"

        HiHat ->
            "hihat"

        Kick ->
            "kick"

        Marimba ->
            "marimba"

        Piano ->
            "piano"

        Snare ->
            "snare"

        Steelpan ->
            "steelpan"

        Wind ->
            "wind"
