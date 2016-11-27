module Tests exposing (..)

import Test exposing (..)
import HttpArchive.TypesTest


all : Test
all =
    describe "Web App Test UI"
        [ HttpArchive.TypesTest.all
        ]
