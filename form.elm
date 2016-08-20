module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


model : Model
model =
    Model "" "" ""


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain passwordAgain ->
            { model | passwordAgain = passwordAgain }


view : Model -> Html Msg
view model =
    div []
        [ inputFactory "text" "Name" Name
        , inputFactory "password" "Password" Password
        , inputFactory "password" "Password Again" PasswordAgain
        , validateForm model
        ]


validateForm model =
    let
        ( color, message ) =
            if model.password == model.passwordAgain then
                ( "green", "OK" )
            else
                ( "red", "Password not match" )
    in
        div [ style [ ( "color", color ) ] ] [ text message ]


inputFactory inputType inputPlaceholder eventTrigger =
    input [ type' inputType, placeholder inputPlaceholder, onInput eventTrigger ] []
