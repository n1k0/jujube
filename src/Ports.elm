port module Ports exposing (mute, setBpm, setTrack)

import Json.Encode as Encode


port mute : Bool -> Cmd msg


port setBpm : Int -> Cmd msg


port setTrack : Encode.Value -> Cmd msg
