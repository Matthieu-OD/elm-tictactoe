module Data.Board exposing (..)

import Data.Players exposing (Player(..))
import List.Extra exposing (getAt, groupsOf)
import Maybe.Extra exposing (orElse)


type alias Board =
    List (Maybe Player)


empty : Board
empty =
    List.repeat 9 Nothing


allEqual : List a -> Bool
allEqual list =
    case list of
        [] ->
            True

        x :: xs ->
            List.all ((==) x) xs


allFilled : Board -> Bool
allFilled board =
    List.all (\x -> x /= Nothing) board


getCell : Int -> List (Maybe Player) -> Maybe Player
getCell index board =
    getAt index board
        |> Maybe.withDefault Nothing


isWinning : Board -> Maybe ( Maybe Player, List Int )
isWinning board =
    isWinningRow board
        |> orElse (isWinningColumn board)
        |> orElse (isWinningDiagonal board)


isWinningList : List (List ( Int, Maybe Player )) -> Maybe ( Maybe Player, List Int )
isWinningList combinaison =
    combinaison
        |> List.map
            (\row ->
                let
                    values =
                        List.map Tuple.second row
                in
                if allEqual values && allFilled values then
                    ( List.head values
                        |> Maybe.withDefault Nothing
                    , List.map Tuple.first row
                    )

                else
                    ( Nothing, [] )
            )
        |> List.filter (Tuple.first >> (/=) Nothing)
        |> List.head


isWinningRow : Board -> Maybe ( Maybe Player, List Int )
isWinningRow board =
    board
        |> List.indexedMap Tuple.pair
        |> groupsOf 3
        |> isWinningList


isWinningColumn : Board -> Maybe ( Maybe Player, List Int )
isWinningColumn board =
    [ [ ( 0, getCell 0 board ), ( 3, getCell 3 board ), ( 6, getCell 6 board ) ]
    , [ ( 1, getCell 1 board ), ( 4, getCell 4 board ), ( 7, getCell 7 board ) ]
    , [ ( 2, getCell 2 board ), ( 5, getCell 5 board ), ( 8, getCell 8 board ) ]
    ]
        |> isWinningList


isWinningDiagonal : Board -> Maybe ( Maybe Player, List Int )
isWinningDiagonal board =
    let
        diagonals =
            [ [ ( 0, getCell 0 board ), ( 4, getCell 4 board ), ( 8, getCell 8 board ) ]
            , [ ( 2, getCell 2 board ), ( 4, getCell 4 board ), ( 6, getCell 6 board ) ]
            ]
    in
    diagonals
        |> isWinningList
