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


type alias Content =
    { size : Int
    , mimeType : String
    , text : String
    }


type alias Response =
    { status : Int
    , statusText : String
    , headers : List Header
    , content : Content
    , headersSize : Int
    , bodySize : Int
    }


header : Decoder Header
header =
    map2 Header
        (field "name" string)
        (field "value" string)


content : Decoder Content
content =
    map3 Content
        (field "size" int)
        (field "mimeType" string)
        (field "text" string)


request : Decoder Request
request =
    map5 Request
        (field "method" string)
        (field "url" string)
        (field "headers" (list header))
        (field "headersSize" int)
        (field "bodySize" int)


response : Decoder Response
response =
    map6 Response
        (field "status" int)
        (field "statusText" string)
        (field "headers" (list header))
        (field "content" content)
        (field "headersSize" int)
        (field "bodySize" int)


parse : Decoder a -> String -> Result String a
parse =
    decodeString
