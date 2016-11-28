module HttpArchive.TypesTest.Fixtures exposing (..)

import HttpArchive.Types exposing (..)
import Date


requestJson : String
requestJson =
    """
{
    "method": "GET",
    "url": "http://www.example.com/path/?param=value",
    "httpVersion": "HTTP/1.1",
    "cookies": [],
    "headers": [],
    "queryString" : [],
    "postData" : {},
    "headersSize" : 150,
    "bodySize" : 0,
    "comment" : ""
}
"""


request : Request
request =
    { method = "GET"
    , url = "http://www.example.com/path/?param=value"
    , headers = []
    , headersSize = 150
    , bodySize = 0
    }


requestWithHeadersJson : String
requestWithHeadersJson =
    """
{
    "method": "GET",
    "url": "http://www.example.com/path/?param=value",
    "httpVersion": "HTTP/1.1",
    "cookies": [],
    "headers": [
      {
        "name": "Accept",
        "value": "text/html; charset=utf-8"
      },
      {
        "name": "X-Hello",
        "value": "Hi"
      }
    ],
    "queryString" : [],
    "postData" : {},
    "headersSize" : 150,
    "bodySize" : 0,
    "comment" : ""
}
"""


requestWithHeaders : Request
requestWithHeaders =
    { method = "GET"
    , url = "http://www.example.com/path/?param=value"
    , headers =
        [ { name = "Accept", value = "text/html; charset=utf-8" }
        , { name = "X-Hello", value = "Hi" }
        ]
    , headersSize = 150
    , bodySize = 0
    }


responseJson : String
responseJson =
    """
{
  "status": 200,
  "statusText": "OK",
  "httpVersion": "HTTP/1.1",
  "cookies": [],
  "headers": [],
  "content": {
    "size": 850,
    "compression": 0,
    "mimeType": "text/html; charset=utf-8",
    "text": "foo",
    "comment": ""
  },
  "redirectURL": "",
  "headersSize" : 160,
  "bodySize" : 850,
  "comment" : ""
}
  """


response : Response
response =
    { status = 200
    , statusText = "OK"
    , headers = []
    , content =
        { size = 850
        , mimeType = "text/html; charset=utf-8"
        , text = Just "foo"
        }
    , headersSize = 160
    , bodySize = 850
    }


responseWithHeadersJson : String
responseWithHeadersJson =
    """
{
  "status": 200,
  "statusText": "OK",
  "httpVersion": "HTTP/1.1",
  "cookies": [],
  "headers": [
    {
      "name": "Accept",
      "value": "text/html; charset=utf-8"
    },
    {
      "name": "X-Hello",
      "value": "Hi"
    }
  ],
  "content": {
    "size": 850,
    "compression": 0,
    "mimeType": "text/html; charset=utf-8",
    "text": "foo",
    "comment": ""
  },
  "redirectURL": "",
  "headersSize" : 160,
  "bodySize" : 850,
  "comment" : ""
}
  """


responseWithHeaders : Response
responseWithHeaders =
    { status = 200
    , statusText = "OK"
    , headers =
        [ { name = "Accept", value = "text/html; charset=utf-8" }
        , { name = "X-Hello", value = "Hi" }
        ]
    , content =
        { size = 850
        , mimeType = "text/html; charset=utf-8"
        , text = Just "foo"
        }
    , headersSize = 160
    , bodySize = 850
    }


entryJson : String
entryJson =
    """
{
    "startedDateTime": "2009-04-16T12:07:23.596Z",
    "time": 50,
    "request":
"""
        ++ requestJson
        ++ """,
    "response":
"""
        ++ responseJson
        ++ """,
    "cache": {},
    "timings": {
        "blocked": 0,
        "dns": -1,
        "connect": 15,
        "send": 20,
        "wait": 38,
        "receive": 12,
        "ssl": -1
    },
    "serverIPAddress": "10.0.0.1",
    "connection": "52492",
    "comment": ""
}
    """


entry : Entry
entry =
    { startedDateTime = (Result.withDefault (Date.fromTime 0) (Date.fromString "2009-04-16T12:07:23.596Z"))
    , time = 50
    , request = request
    , response = response
    , timings = timings
    }


timings : Timings
timings =
    { blocked = 0
    , dns = -1
    , connect = 15
    , send = 20
    , wait = 38
    , receive = 12
    , ssl = -1
    }


pageJson : String
pageJson =
    """
{
  "startedDateTime": "2009-04-16T12:07:25.123+01:00",
  "id": "page_0",
  "title": "Test Page",
  "pageTimings": {
    "onContentLoad": 1720,
    "onLoad": 2500,
    "comment": ""
  },
  "comment": ""
}
    """


page : Page
page =
    { startedDateTime = (Result.withDefault (Date.fromTime 0) (Date.fromString "2009-04-16T12:07:25.123+01:00"))
    , id = "page_0"
    , title = "Test Page"
    , pageTimings =
        { onContentLoad = 1720
        , onLoad = 2500
        }
    }


logJson : String
logJson =
    """
{
    "log": {
        "version" : "1.2",
        "creator" : {},
        "browser" : {},
        "pages": [
        """
        ++ pageJson
        ++ """
        ],
        "entries": [
    """
        ++ entryJson
        ++ """
        ,
    """
        ++ entryJson
        ++ """
        ],
        "comment": ""
    }
}
    """


log : Log
log =
    { pages = [ page ]
    , entries = [ entry, entry ]
    }
