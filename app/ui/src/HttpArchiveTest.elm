module HttpArchiveTest exposing (all)

import Date
import Test exposing (..)
import Expect
import Expectations as MyExpect
import HttpArchive exposing (..)


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


request =
    { method = "GET"
    , url = "http://www.example.com/path/?param=value"
    , headers = []
    , headersSize = 150
    , bodySize = 0
    }


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


timings =
    { blocked = 0
    , dns = -1
    , connect = 15
    , send = 20
    , wait = 38
    , receive = 12
    , ssl = -1
    }


entry =
    { startedDateTime = (Result.withDefault (Date.fromTime 0) (Date.fromString "2009-04-16T12:07:23.596Z"))
    , time = 50
    , request = request
    , response = response
    , timings = timings
    }


logJson =
    """
{
    "log": {
        "version" : "1.2",
        "creator" : {},
        "browser" : {},
        "pages": [],
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


log =
    { entries = [ entry, entry ]
    }



-- Helpers


type alias TestDescription outputType =
    { description : String
    , output : outputType
    , expected : outputType
    }


equalityTest : TestDescription out -> Test
equalityTest { description, output, expected } =
    test description <|
        \_ -> Expect.equal expected output


equalityTests =
    List.map equalityTest



-- Tests


all : Test
all =
    describe "HttpArchive"
        [ describe "Parsing a Request"
            (equalityTests
                [ { description = "decodes a request with no headers"
                  , output = (parse HttpArchive.request requestJson)
                  , expected = Ok request
                  }
                , { description = "decodes a request with headers"
                  , output = (parse HttpArchive.request requestWithHeadersJson)
                  , expected = Ok requestWithHeaders
                  }
                ]
            )
        , describe "Parsing a Response"
            (equalityTests
                [ { description = "decodes a response with no headers"
                  , output = (parse HttpArchive.response responseJson)
                  , expected = Ok response
                  }
                , { description = "decodes a response with headers"
                  , output = (parse HttpArchive.response responseWithHeadersJson)
                  , expected = Ok responseWithHeaders
                  }
                ]
            )
        , describe "Parsing an Entry"
            (equalityTests
                [ { descriptions = "decodes an entry with timings, request and response"
                  , output = (parse HttpArchive.entry entryJson)
                  , expected = Ok entry
                  }
                ]
            )
        , describe "Parsing a Log"
            (equalityTests
                [ { description = "decodes a log with two full entries"
                  , output = (parse HttpArchive.log logJson)
                  , expected = Ok log
                  }
                ]
            )
        ]
