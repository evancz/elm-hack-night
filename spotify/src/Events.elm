module Events exposing (onEnter)

{-| Extensions to the Html.Events library.

@docs onEnter
-}

import Html exposing (Attribute)
import Html.Events exposing (..)
import Json.Decode as Decode


onEnter : msg -> Attribute msg
onEnter msg =
    on "keydown"
        (Decode.customDecoder keyCode is13
            |> Decode.map (always msg)
        )


is13 : Int -> Result String ()
is13 code =
    if code == 13 then
        Ok ()
    else
        Err "not the right key code"
