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


all : Test
all =
    describe "HttpArchive"
        [ describe "Parsing a log"
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
        ]
