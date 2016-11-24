module HttpArchive exposing (..)

import Json.Decode exposing (..)
import Date


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


type alias Entry =
    { startedDateTime : Date.Date
    , time : Int
    , request : Request
    , response : Response
    , timings : Timings
    }


type alias Timings =
    { blocked : Int
    , dns : Int
    , connect : Int
    , send : Int
    , wait : Int
    , receive : Int
    , ssl : Int
    }


type alias Log =
    { entries : List Entry
    }


fromJson : String -> Result Log
fromJson json =
    parse log json


dateStringDecode : String -> Decoder Date.Date
dateStringDecode str =
    case Date.fromString str of
        Err err ->
            fail err

        Ok d ->
            succeed d


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


timings : Decoder Timings
timings =
    map7 Timings
        (field "blocked" int)
        (field "dns" int)
        (field "connect" int)
        (field "send" int)
        (field "wait" int)
        (field "receive" int)
        (field "ssl" int)


entry : Decoder Entry
entry =
    map5 Entry
        (field "startedDateTime" (string |> andThen dateStringDecode))
        (field "time" int)
        (field "request" request)
        (field "response" response)
        (field "timings" timings)


log : Decoder Log
log =
    map Log
        (field "entries" (list entry))


parse : Decoder a -> String -> Result String a
parse =
    decodeString
