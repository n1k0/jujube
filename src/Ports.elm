port module Ports exposing (pauseTransport, setBpm, setSequence, startTransport, stopTransport)

import Json.Encode as Encode


port pauseTransport : () -> Cmd msg


port setBpm : Int -> Cmd msg


port setSequence : Encode.Value -> Cmd msg


port startTransport : () -> Cmd msg


port stopTransport : () -> Cmd msg
