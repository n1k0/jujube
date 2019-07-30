module Data.Scale exposing (Scale, maj7, min7, penta, range)


type Scale
    = Scale (List String)


min7 : List String
min7 =
    [ "C", "Eb", "G", "Bb" ]


maj7 : List String
maj7 =
    [ "C", "E", "G", "B" ]


penta : List String
penta =
    [ "A", "C", "D", "E", "F", "G" ]


range : Int -> Int -> List String -> List String
range minOctave maxOctave notes =
    List.range minOctave maxOctave
        |> List.map (\oct -> notes |> List.map (\n -> n ++ String.fromInt oct))
        |> List.concat
