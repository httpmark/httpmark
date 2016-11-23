module HttpArchive exposing (..)

import Json.Decode exposing (..)


type alias Header =
    { name : String
    , value : String
    }


type alias Request =
    { method : String
    , url : String
    , headers : List Header
    , headersSize : Int
    , bodySize : Int
    }


header : Decoder Header
header =
    map2 Header
        (field "name" string)
        (field "value" string)


request : Decoder Request
request =
    map5 Request
        (field "method" string)
        (field "url" string)
        (field "headers" (list header))
        (field "headersSize" int)
        (field "bodySize" int)


parse : Decoder a -> String -> Result String a
parse =
    decodeString
