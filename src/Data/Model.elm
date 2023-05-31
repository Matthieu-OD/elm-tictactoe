module Data.Model exposing (..)

import Data.Board exposing (Board)
import Data.Players exposing (Player(..))


type alias Model =
    { board : Board
    , nextPlayer : Player
    }
