module Counter exposing (Model, Msg, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { count : Int
    , clicked : Int
    , max : Int
    , min : Int
    }


init : Int -> Model
init count =
    { count = count
    , clicked = 0
    , max = 0
    , min = 0
    }



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    let
        clicked =
            model.clicked + 1
    in
        case msg of
            Increment ->
                let
                    count =
                        model.count + 1

                    max =
                        if model.max < count then
                            count
                        else
                            model.max
                in
                    { model | count = count, clicked = clicked, max = max }

            Decrement ->
                let
                    count =
                        model.count - 1

                    min =
                        if model.min > count then
                            count
                        else
                            model.min
                in
                    { model | count = count, clicked = clicked, min = min }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [ countStyle ] [ text (toString model.count) ]
        , button [ onClick Increment ] [ text "+" ]
        , br [] []
        , span [] [ text ("Clicked " ++ toString model.clicked ++ " times") ]
        , br [] []
        , span [] [ text ("Min: " ++ toString model.min ++ "; Max: " ++ toString model.max) ]
        , br [] []
        ]


countStyle : Attribute msg
countStyle =
    style
        [ ( "font-size", "20px" )
        , ( "font-family", "monospace" )
        , ( "display", "inline-block" )
        , ( "width", "50px" )
        , ( "text-align", "center" )
        ]
