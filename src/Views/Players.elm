module Views.Players exposing (view)

import Data.Msg exposing (Msg)
import Data.Players exposing (Player(..))
import Html exposing (..)
import Html.Attributes exposing (..)


view : Maybe Player -> Html Msg
view maybePlayer =
    maybePlayer
        |> Maybe.andThen
            (\player ->
                case player of
                    Cross ->
                        Just cross

                    Circle ->
                        Just circle
            )
        |> Maybe.withDefault empty


cross : Html Msg
cross =
    div
        [ attribute "style" "background: url('static/cross.png') center no-repeat; background-size: contain;"
        , class "w-full h-full"
        ]
        []


circle : Html Msg
circle =
    div
        [ attribute "style" "background: url('static/circle.png') center no-repeat; background-size: contain;"
        , class "w-full h-full"
        ]
        []


empty : Html Msg
empty =
    div
        [ class "w-full h-full"
        ]
        []
