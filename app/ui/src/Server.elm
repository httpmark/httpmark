module Server exposing (send, listen)

import WebSocket


webSocketUrl =
    "ws://localhost:3000/stream"


send : String -> Cmd msg
send input =
    WebSocket.send webSocketUrl input


listen : (String -> msg) -> Sub msg
listen msg =
    WebSocket.listen webSocketUrl msg
