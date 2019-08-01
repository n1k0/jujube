module Data.Instrument exposing (Instrument(..), encode, random, toString)

import Json.Encode as Encode
import Random exposing (Generator)
import Random.List as RandomList


type Instrument
    = Bass
    | Brass
    | Cello
    | Kalimba
    | Marimba
    | Piano
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

        Marimba ->
            "marimba"

        Piano ->
            "piano"

        Steelpan ->
            "steelpan"

        Wind ->
            "wind"
