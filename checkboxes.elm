module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck)


main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { red : Bool
    , underline : Bool
    , bold : Bool
    }


model : Model
model =
    Model False False False



-- UPDATE


type Msg
    = Red Bool
    | Underline Bool
    | Bold Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        Red bool ->
            { model | red = bool }

        Underline bool ->
            { model | underline = bool }

        Bold bool ->
            { model | bold = bool }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ span [ toStyle model ] [ text "Lorem ipsum dolor" ]
        , makeBox model.red Red "Red"
        , makeBox model.underline Underline "Underline"
        , makeBox model.bold Bold "Bold"
        ]


toStyle : Model -> Attribute msg
toStyle model =
    style
        [ ( "color"
          , if model.red then
                "red"
            else
                "black"
          )
        , ( "text-decoration"
          , if model.underline then
                "underline"
            else
                "none"
          )
        , ( "font-weight"
          , if model.bold then
                "bold"
            else
                "normal"
          )
        ]


makeBox checked' onCheck' text' =
    label []
        [ br [] []
        , input [ type' "checkbox", checked checked', onCheck onCheck' ] []
        , text text'
        ]
