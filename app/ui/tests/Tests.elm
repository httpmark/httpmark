module Tests exposing (..)

import Test exposing (..)
import ModelTest


all : Test
all =
    describe "Sample Test Suite"
        [ ModelTest.all
        ]
