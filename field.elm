module Main exposing (..)

import Html exposing (text, div, input)
import Html.App exposing (beginnerProgram)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String


main =
    beginnerProgram { model = "", view = view, update = update }


type Msg
    = NewContent String


update (NewContent content) oldContent =
    content


view content =
    div []
        [ input [ placeholder "Reverse me", onInput NewContent, myStyle ] []
        , div [] [ text (String.reverse content) ]
        ]


myStyle =
    style
        [ ( "width", "100%" )
        , ( "padding", "10px 0" )
        ]
