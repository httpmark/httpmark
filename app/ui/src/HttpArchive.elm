module HttpArchive exposing (..)

import HttpArchive.Types exposing (Log, log, parse)


fromJson : String -> Result String Log
fromJson json =
    parse log json
