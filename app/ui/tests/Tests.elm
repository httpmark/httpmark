module Tests exposing (..)

import Test exposing (..)
import HttpArchiveTest


all : Test
all =
    describe "Web App Test UI"
        [ HttpArchiveTest.all
        ]
