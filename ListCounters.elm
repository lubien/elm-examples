module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import OriginalCounter as Counter


main =
    App.beginnerProgram
        { view = view
        , update = update
        , model = init
        }



-- MODEL


type alias Model =
    { counters : List IndexedCounter
    , uid : Int
    }


type alias IndexedCounter =
    { id : Int
    , model : Counter.Model
    }


init : Model
init =
    { counters = []
    , uid = 0
    }



-- UPDATE


type Msg
    = Insert
    | Remove
    | Modify Int Counter.Msg


update : Msg -> Model -> Model
update msg ({ counters, uid } as model) =
    case msg of
        Insert ->
            { model
                | counters = counters ++ [ IndexedCounter uid (Counter.init 0) ]
                , uid = uid + 1
            }

        Remove ->
            { model | counters = List.drop 1 counters }

        Modify id msg ->
            { model | counters = List.map (updateHelp id msg) counters }


updateHelp : Int -> Counter.Msg -> IndexedCounter -> IndexedCounter
updateHelp targetId msg { id, model } =
    IndexedCounter id
        (if targetId == id then
            Counter.update msg model
         else
            model
        )



-- VIEW


view : Model -> Html Msg
view model =
    let
        remove =
            button [ onClick Remove ] [ text "Remove" ]

        insert =
            button [ onClick Insert ] [ text "Add" ]

        counters =
            List.map viewIndexedCounter model.counters
    in
        div [] ([ remove, insert ] ++ counters)


viewIndexedCounter : IndexedCounter -> Html Msg
viewIndexedCounter { id, model } =
    App.map (Modify id) (Counter.view model)
