module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Random


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { dieface : Int
    }


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 256) )

        NewFace newFace ->
            ( Model newFace, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString model.dieface) ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]


init : ( Model, Cmd Msg )
init =
    ( Model 1, Cmd.none )
