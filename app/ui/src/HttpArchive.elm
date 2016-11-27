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
    , text : Maybe String
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
    , time : Float
    , request : Request
    , response : Response
    , timings : Timings
    }


type alias Timings =
    { blocked : Float
    , dns : Float
    , connect : Float
    , send : Float
    , wait : Float
    , receive : Float
    , ssl : Float
    }


type alias Page =
    { startedDateTime : Date.Date
    , id : String
    , title : String
    , pageTimings : PageTimings
    }


type alias PageTimings =
    { onContentLoad : Float
    , onLoad : Float
    }


type alias Log =
    { pages : List Page
    , entries : List Entry
    }


fromJson : String -> Result String Log
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
        (maybe (field "text" string))


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
        (field "blocked" float)
        (field "dns" float)
        (field "connect" float)
        (field "send" float)
        (field "wait" float)
        (field "receive" float)
        (field "ssl" float)


entry : Decoder Entry
entry =
    map5 Entry
        (field "startedDateTime" (string |> andThen dateStringDecode))
        (field "time" float)
        (field "request" request)
        (field "response" response)
        (field "timings" timings)


pageTimings : Decoder PageTimings
pageTimings =
    map2 PageTimings
        (field "onContentLoad" float)
        (field "onLoad" float)


page : Decoder Page
page =
    map4 Page
        (field "startedDateTime" (string |> andThen dateStringDecode))
        (field "id" string)
        (field "title" string)
        (field "pageTimings" pageTimings)


log : Decoder Log
log =
    field "log" <|
        map2 Log
            (field "pages" (list page))
            (field "entries" (list entry))


parse : Decoder a -> String -> Result String a
parse =
    decodeString
