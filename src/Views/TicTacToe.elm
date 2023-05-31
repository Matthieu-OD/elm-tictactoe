module Views.TicTacToe exposing (..)

import Data.Board as Board
import Data.Msg exposing (Msg(..))
import Data.Players exposing (Player(..))
import Html exposing (..)
import Html.Attributes exposing (attribute, class, readonly)
import Html.Events exposing (onClick)
import List.Extra exposing (groupsOf)
import Views.Players as Players


cell : List Int -> Int -> Int -> Maybe Player -> Html Msg
cell combinaison rowId cellId player =
    let
        cellNumber =
            rowId * 3 + cellId

        bgClass =
            if List.member cellNumber combinaison then
                "bg-green-500"

            else
                ""
    in
    td
        [ if combinaison == [] then
            Play cellNumber |> onClick

          else
            readonly True
        , class <| "w-25 h-25 p-4 " ++ bgClass
        ]
        [ Players.view player ]


row : List Int -> Int -> List (Maybe Player) -> Html Msg
row combinaison rowId players =
    players
        |> List.indexedMap (cell combinaison rowId)
        |> tr []


view : List (Maybe Player) -> Html Msg
view board =
    div []
        [ h1 [ class "text-4xl font-bold" ]
            [ text "Tic Tac Toe" ]
        , case Board.isWinning board of
            Just ( Just Circle, combinaison ) ->
                div []
                    [ h2 [ class "text-2xl text-center" ] [ text "Circle won!" ]
                    , displayBoard board combinaison
                    ]

            Just ( Just Cross, combinaison ) ->
                div []
                    [ h2 [ class "text-2xl text-center" ] [ text "Cross won!" ]
                    , displayBoard board combinaison
                    ]

            _ ->
                div []
                    [ h2 [] [ text "\u{00A0}" ]
                    , displayBoard board []
                    ]
        , if board /= Board.empty then
            div [ class "w-full flex justify-center" ]
                [ button
                    [ class "p-2 bg-gray-700 text-white m-5"
                    , onClick Reset
                    ]
                    [ text "Reset" ]
                ]

          else
            text ""
        ]


displayBoard : List (Maybe Player) -> List Int -> Html Msg
displayBoard board combinaison =
    div []
        [ groupsOf 3 board
            |> List.indexedMap (row combinaison)
            |> table
                [ class "m-auto w-[400px] h-[400px] text-center"
                , attribute "style" "background:url('static/table.png') center no-repeat; background-size: contain;"
                ]
        ]
