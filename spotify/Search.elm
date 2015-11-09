module Search where

import Effects exposing (Effects, Never)
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json
import Task


-- MODEL

type alias Model =
    { query : String
    , answers : List Answer
    }


type alias Answer =
    { name : String
    }


init : String -> (Model, Effects Action)
init =
  ( Model "" []
  , search topic
  )



-- UPDATE


type Action
    = RequestMore
    | NewGif (Maybe String)


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    RequestMore ->
      (model, search model.topic)

    NewGif maybeUrl ->
      ( Model model.topic (Maybe.withDefault model.gifUrl maybeUrl)
      , Effects.none
      )



-- VIEW


(=>) = (,)


view : Signal.Address Action -> Model -> Html
view address model =
  div [] []



-- EFFECTS


search : String -> Effects Action
search query =
  Http.get decodeAlbums (searchUrl query)
    |> Task.toMaybe
    |> Task.map SearchResults
    |> Effects.task


searchUrl : String -> String
searchUrl query =
  Http.url "https://api.spotify.com/v1/search"
    [ "q" => query
    , "type" => "album"
    ]


decodeAlbums : Json.Decoder (List String)
decodeAlbums =
  let
    albumName =
      "name" := Json.string
  in
    Json.at ["albums", "items"] (Json.list albumName)
