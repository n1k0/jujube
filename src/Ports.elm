port module Ports exposing (mute, setBpm, setSequence)

import Json.Encode as Encode


port mute : Bool -> Cmd msg


port setBpm : Int -> Cmd msg


port setSequence : ( String, Encode.Value ) -> Cmd msg
