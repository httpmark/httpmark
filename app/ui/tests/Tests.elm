module Tests exposing (..)

import Test exposing (..)
import ModelTest
import HttpArchiveTest


all : Test
all =
    describe "Web App Test UI"
        [ ModelTest.all
        , HttpArchiveTest.all
        ]
