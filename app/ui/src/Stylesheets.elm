port module Stylesheets exposing (..)

import Css exposing (stylesheet)
import Css.File exposing (..)
import Components exposing (css)


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "styles.css", compile [ stylesheet css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles
