module HttpArchive.TypesTest exposing (all)

import Date
import Test exposing (..)
import TestHelpers exposing (equalityTests)
import HttpArchive.Types as HARTypes exposing (parse)
import HttpArchive.TypesTest.Fixtures exposing (..)


all : Test
all =
    describe "HttpArchive"
        [ describe "Parsing a Request"
            (equalityTests
                [ { description = "decodes a request with no headers"
                  , output = (parse HARTypes.request requestJson)
                  , expected = Ok request
                  }
                , { description = "decodes a request with headers"
                  , output = (parse HARTypes.request requestWithHeadersJson)
                  , expected = Ok requestWithHeaders
                  }
                ]
            )
        , describe "Parsing a Response"
            (equalityTests
                [ { description = "decodes a response with no headers"
                  , output = (parse HARTypes.response responseJson)
                  , expected = Ok response
                  }
                , { description = "decodes a response with headers"
                  , output = (parse HARTypes.response responseWithHeadersJson)
                  , expected = Ok responseWithHeaders
                  }
                ]
            )
        , describe "Parsing an Entry"
            (equalityTests
                [ { description = "decodes an entry with timings, request and response"
                  , output = (parse HARTypes.entry entryJson)
                  , expected = Ok entry
                  }
                ]
            )
        , describe "Parsing a Page"
            (equalityTests
                [ { description = "decodes a page"
                  , output = (parse HARTypes.page pageJson)
                  , expected = Ok page
                  }
                ]
            )
        , describe "Parsing a Log"
            (equalityTests
                [ { description = "decodes a log with two full entries"
                  , output = (parse HARTypes.log logJson)
                  , expected = Ok log
                  }
                ]
            )
        ]
