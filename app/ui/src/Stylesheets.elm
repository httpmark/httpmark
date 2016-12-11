port module Stylesheets exposing (..)

import Css.File exposing (..)
import Components exposing (css)


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "styles.css", compile [ css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles
