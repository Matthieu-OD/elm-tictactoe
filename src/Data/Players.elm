module Data.Players exposing (Player(..), next)


type Player
    = Cross
    | Circle


next : Maybe Player -> Player
next maybePlayer =
    maybePlayer
        |> Maybe.andThen
            (\player ->
                case player of
                    Cross ->
                        Just Circle

                    Circle ->
                        Just Cross
            )
        |> Maybe.withDefault Cross
