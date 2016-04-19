module Rest (..) where

import Effects exposing (Effects, Never)
import Types exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode exposing ((:=),Decoder)
import Signal exposing (message, forwardTo, Address)
import Task
import Types exposing (..)


search : String -> Effects Action
search query =
  Http.get decodeAnswers (searchUrl query)
    |> Task.toMaybe
    |> Task.map RegisterAnswers
    |> Effects.task


searchUrl : String -> String
searchUrl query =
  Http.url
    "https://api.spotify.com/v1/search"
    [ ( "q", query )
    , ( "type", "album" )
    ]


decodeAnswers : Decoder (List Answer)
decodeAnswers =
  let
    albumName =
      Decode.map Answer ("name" := Decode.string)
  in
    (Decode.at [ "albums", "items" ] (Decode.list albumName))
