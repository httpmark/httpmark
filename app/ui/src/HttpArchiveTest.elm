module HttpArchiveTest exposing (all)

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


malformedRequestJson =
    """
{
"method": "GET",
"url": "http://www.example.com/path/?param=value",
"httpVersion": "HTTP/1.1",
"cookies": [],
"headers": ["foo", "bar"],
"queryString" : [],
"postData" : {},
"headersSize" : 150,
"bodySize" : 0,
"comment" : ""
}
"""


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


malformedResponseJson =
    """
{
  "status": 200,
  "statusText": "OK",
  "httpVersion": "HTTP/1.1",
  "cookies": [],
  "headers": ["foo"],
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


all : Test
all =
    describe "HttpArchive"
        [ describe "Parsing a Request"
            [ test "decodes a request with no headers" <|
                \_ ->
                    let
                        input =
                            requestJson

                        output =
                            (parse HttpArchive.request input)

                        expected =
                            Ok
                                { method = "GET"
                                , url = "http://www.example.com/path/?param=value"
                                , headers = []
                                , headersSize = 150
                                , bodySize = 0
                                }
                    in
                        Expect.equal expected output
            , test "decodes a request with headers" <|
                \_ ->
                    let
                        input =
                            requestWithHeadersJson

                        output =
                            (parse HttpArchive.request input)

                        expected =
                            Ok
                                { method = "GET"
                                , url = "http://www.example.com/path/?param=value"
                                , headers =
                                    [ { name = "Accept", value = "text/html; charset=utf-8" }
                                    , { name = "X-Hello", value = "Hi" }
                                    ]
                                , headersSize = 150
                                , bodySize = 0
                                }
                    in
                        Expect.equal expected output
            , test "returns error for invalid JSON" <|
                \_ ->
                    let
                        input =
                            malformedRequestJson
                    in
                        MyExpect.err (parse HttpArchive.request input)
            ]
        , describe "Parsing a Response"
            [ test "decodes a response with no headers" <|
                \_ ->
                    let
                        input =
                            responseJson

                        output =
                            (parse HttpArchive.response input)

                        expected =
                            Ok
                                { status = 200
                                , statusText = "OK"
                                , headers = []
                                , content =
                                    { size = 850
                                    , mimeType = "text/html; charset=utf-8"
                                    , text = "foo"
                                    }
                                , headersSize = 160
                                , bodySize = 850
                                }
                    in
                        Expect.equal expected output
            , test "decodes a response with headers" <|
                \_ ->
                    let
                        input =
                            responseWithHeadersJson

                        output =
                            (parse HttpArchive.response input)

                        expected =
                            Ok
                                { status = 200
                                , statusText = "OK"
                                , headers =
                                    [ { name = "Accept", value = "text/html; charset=utf-8" }
                                    , { name = "X-Hello", value = "Hi" }
                                    ]
                                , content =
                                    { size = 850
                                    , mimeType = "text/html; charset=utf-8"
                                    , text = "foo"
                                    }
                                , headersSize = 160
                                , bodySize = 850
                                }
                    in
                        Expect.equal expected output
            , test "returns error for invalid JSON" <|
                \_ ->
                    let
                        input =
                            malformedResponseJson
                    in
                        MyExpect.err (parse HttpArchive.response input)
            ]
        ]
