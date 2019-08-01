port module Ports exposing (load, ready, setBpm, setDrumTracks, setTrack, start, stop)

import Json.Encode as Encode



--Commands


port load : () -> Cmd msg


port start : () -> Cmd msg


port stop : () -> Cmd msg


port setBpm : Int -> Cmd msg


port setDrumTracks : Encode.Value -> Cmd msg


port setTrack : Encode.Value -> Cmd msg



-- Subscriptions


port ready : (Bool -> msg) -> Sub msg
