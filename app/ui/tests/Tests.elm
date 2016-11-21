module Tests exposing (..)

import Test exposing (..)
import ModelTest


all : Test
all =
    describe "Web App Test UI"
        [ ModelTest.all
        ]
