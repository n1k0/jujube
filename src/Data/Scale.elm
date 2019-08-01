module Data.Scale exposing
    ( diat
    , fifth
    , first
    , fourth
    , penta
    , range
    , second
    , seventh
    , sixth
    , third
    )


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
