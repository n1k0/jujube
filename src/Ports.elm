port module Ports exposing (setBpm, setTrack, start, stop)

import Json.Encode as Encode


port start : () -> Cmd msg


port stop : () -> Cmd msg


port setBpm : Int -> Cmd msg


port setTrack : Encode.Value -> Cmd msg
