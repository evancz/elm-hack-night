module Events
  (onChange, onEnter)
  where

{-| Extensions to the Html.Events library.

@docs onEnter
-}

import Html exposing (Attribute)
import Html.Events exposing (..)
import Json.Decode as Json
import Signal exposing (..)


onEnter : Address a -> a -> Attribute
onEnter address value =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (\_ -> Signal.message address value)


is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"


onChange : Address a -> (String -> a) -> Html.Attribute
onChange address f =
  on "change" targetValue (message (forwardTo address f))
