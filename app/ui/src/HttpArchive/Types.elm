module HttpArchive.Types exposing (..)

import Json.Decode exposing (..)
import HttpArchive.Json exposing (date)
import Date exposing (Date)


type alias Log =
    { pages : List Page
    , entries : List Entry
    }


log : Decoder Log
log =
    field "log" <|
        map2 Log
            (field "pages" (list page))
            (field "entries" (list entry))


type alias Page =
    { startedDateTime : Date
    , id : String
    , title : String
    , pageTimings : PageTimings
    }


page : Decoder Page
page =
    map4 Page
        (field "startedDateTime" date)
        (field "id" string)
        (field "title" string)
        (field "pageTimings" pageTimings)


type alias PageTimings =
    { onContentLoad : Float
    , onLoad : Float
    }


pageTimings : Decoder PageTimings
pageTimings =
    map2 PageTimings
        (field "onContentLoad" float)
        (field "onLoad" float)


type alias Entry =
    { startedDateTime : Date
    , time : Float
    , request : Request
    , response : Response
    , timings : Timings
    }


entry : Decoder Entry
entry =
    map5 Entry
        (field "startedDateTime" date)
        (field "time" float)
        (field "request" request)
        (field "response" response)
        (field "timings" timings)


type alias Request =
    { method : String
    , url : String
    , headers : List Header
    , headersSize : Int
    , bodySize : Int
    }


request : Decoder Request
request =
    map5 Request
        (field "method" string)
        (field "url" string)
        (field "headers" (list header))
        (field "headersSize" int)
        (field "bodySize" int)


type alias Response =
    { status : Int
    , statusText : String
    , headers : List Header
    , content : Content
    , headersSize : Int
    , bodySize : Int
    }


response : Decoder Response
response =
    map6 Response
        (field "status" int)
        (field "statusText" string)
        (field "headers" (list header))
        (field "content" content)
        (field "headersSize" int)
        (field "bodySize" int)


type alias Header =
    { name : String
    , value : String
    }


header : Decoder Header
header =
    map2 Header
        (field "name" string)
        (field "value" string)


type alias Content =
    { size : Int
    , mimeType : String
    , text : Maybe String
    }


content : Decoder Content
content =
    map3 Content
        (field "size" int)
        (field "mimeType" string)
        (maybe (field "text" string))


type alias Timings =
    { blocked : Float
    , dns : Float
    , connect : Float
    , send : Float
    , wait : Float
    , receive : Float
    , ssl : Float
    }


timings : Decoder Timings
timings =
    map7 Timings
        (field "blocked" float)
        (field "dns" float)
        (field "connect" float)
        (field "send" float)
        (field "wait" float)
        (field "receive" float)
        (field "ssl" float)


parse : Decoder a -> String -> Result String a
parse =
    decodeString
