module App exposing (..)

import Browser
import Data.Board as Board
import Data.Model exposing (Model)
import Data.Msg exposing (Msg(..))
import Data.Players as Players exposing (Player(..))
import Html exposing (Html, div)
import List.Extra exposing (getAt, setAt)
import Views.TicTacToe as TicTacToe


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


init : Model
init =
    { board = Board.empty
    , nextPlayer = Players.next Nothing
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Play cellId ->
            let
                currentCellValue =
                    getAt cellId model.board
                        |> Maybe.withDefault Nothing

                newCellValue =
                    if currentCellValue == Nothing then
                        Just model.nextPlayer

                    else
                        Nothing
            in
            { model
                | board = setAt cellId newCellValue model.board
                , nextPlayer = Players.next <| Just model.nextPlayer
            }

        Reset ->
            init


view : Model -> Html Msg
view model =
    div []
        [ TicTacToe.view model.board
        ]
