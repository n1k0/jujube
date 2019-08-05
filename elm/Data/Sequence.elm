module Data.Sequence exposing (Sequence(..), encode, random)

import Array
import Data.Note as Note exposing (Note)
import Json.Encode as Encode
import Random exposing (Generator)
import Random.Array as RandomArray
import Random.List as RandomList


type Sequence
    = Silence
    | Single Note
    | Multiple (List Sequence)


encode : Sequence -> Encode.Value
encode seq =
    case seq of
        Silence ->
            Encode.null

        Single note ->
            Note.encode note

        Multiple subSeq ->
            Encode.list encode subSeq


pickOne : List String -> Generator Sequence
pickOne =
    RandomList.choose
        >> Random.andThen
            (Tuple.first
                >> Maybe.map (Note.randomFromPitch >> Random.andThen (Single >> Random.constant))
                >> Maybe.withDefault (Random.constant Silence)
            )


pickMany : Int -> List String -> Generator Sequence
pickMany length =
    pickOne
        >> RandomArray.array length
        >> Random.andThen (Array.toList >> Multiple >> Random.constant)


decideWhat : List String -> Float -> Generator Sequence
decideWhat notes prob =
    if prob > 0.97 then
        pickMany 3 notes

    else if prob > 0.8 then
        Random.constant Silence

    else if prob > 0.6 then
        pickOne notes

    else if prob > 0.2 then
        pickMany 2 notes

    else
        pickMany 4 notes


random : Int -> List String -> Generator Sequence
random bars notes =
    Random.float 0 1
        |> Random.andThen (decideWhat notes)
        |> RandomArray.rangeLengthArray bars bars
        |> Random.andThen (Array.toList >> Multiple >> Random.constant)
