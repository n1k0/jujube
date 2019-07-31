module Data.Scale exposing (Scale, diat, maj7, min7, penta, range)


type Scale
    = Scale (List String)


min7 : List String
min7 =
    [ "C", "Eb", "G", "Bb" ]


maj7 : List String
maj7 =
    [ "C", "E", "G", "B" ]


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
