module Events
  (onChange)
  where

{-| Extensions to the Html.Events library.

@docs onEnter
-}

import Html exposing (Attribute)
import Html.Events exposing (..)
import Json.Decode exposing (customDecoder)
import Signal exposing (..)

keyCodeIs : Int -> Int -> Result String ()
keyCodeIs expected actual =
  if expected == actual
  then Ok ()
  else Err "Not the right key code"

enterKey : Int -> Result String ()
enterKey = keyCodeIs 13

onChange : Address a -> (String -> a) -> Html.Attribute
onChange address f = on "change" targetValue (message (forwardTo address f))
