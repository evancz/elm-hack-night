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
    = QueryChange String
    | RegisterAnswers (Maybe (List Answer))


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    QueryChange newQuery ->
      ( Model newQuery model.answers
      , search newQuery
      )

    RegisterAnswers maybeAnswers ->
      ( Model model.query (Maybe.withDefault [] maybeAnswers)
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
    |> Task.map RegisterAnswers
    |> Effects.task


searchUrl : String -> String
searchUrl query =
  Http.url "https://api.spotify.com/v1/search"
    [ "q" => query
    , "type" => "album"
    ]


decodeAnswers : Json.Decoder (List Answer)
decodeAnswers =
  let
    albumName =
      "name" := Json.string
  in
    Json.map Answer (Json.at ["albums", "items"] (Json.list albumName))
