module Data.Scale exposing
    ( diat
    , fifth
    , first
    , fourth
    , penta
    , randomNext
    , range
    , second
    , seventh
    , sixth
    , third
    )

import Random exposing (Generator)
import Random.List as RandomList


first : List String
first =
    [ "C", "E", "G", "B" ]


second : List String
second =
    [ "D", "F", "A", "C" ]


third : List String
third =
    [ "E", "G", "B", "D" ]


fourth : List String
fourth =
    [ "F", "A", "C", "E" ]


fifth : List String
fifth =
    [ "G", "B", "D", "F" ]


sixth : List String
sixth =
    [ "A", "C", "E", "G" ]


seventh : List String
seventh =
    [ "B", "D", "F", "A" ]


diat : List String
diat =
    [ "C", "D", "E", "F", "G", "A", "B" ]


penta : List String
penta =
    [ "A", "C", "D", "E", "F", "G" ]


range : ( Int, Int ) -> List String -> List String
range ( min, max ) notes =
    List.range min max
        |> List.map (\oct -> notes |> List.map (\n -> n ++ String.fromInt oct))
        |> List.concat


takeSeventh : List String -> Generator (List String)
takeSeventh scale =
    Random.float 0 1
        |> Random.andThen
            (\prob ->
                if prob > 0.8 then
                    Random.constant scale

                else
                    Random.constant (List.take 3 scale)
            )


pickOne : List (List String) -> Generator (List String)
pickOne choices =
    RandomList.choose choices
        |> Random.andThen (Tuple.first >> Maybe.withDefault first >> Random.constant)
        |> Random.andThen takeSeventh


randomNext : List String -> Generator (List String)
randomNext scale =
    if scale == first then
        pickOne [ second, third, fourth, fifth, sixth ]

    else if scale == second then
        pickOne [ first, third, fourth, fifth, sixth ]

    else if scale == third then
        pickOne [ first, second, fourth, fifth, sixth ]

    else if scale == fourth then
        pickOne [ first, second, third, fifth, sixth ]

    else if scale == fifth then
        pickOne [ first, fourth ]

    else if scale == sixth then
        pickOne [ first, second, third, fourth, fifth ]

    else
        Random.constant first
