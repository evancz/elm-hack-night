module State (..) where

import Effects exposing (Effects, Never)
import Events exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json exposing ((:=))
import Signal exposing (message, forwardTo, Address)
import Task
import Types exposing (..)
import Rest


init : ( Model, Effects Action )
init =
  ( { query = ""
    , answers = []
    }
  , Effects.none
  )


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    QueryChange newQuery ->
      ( { model | query = newQuery }
      , Effects.none
      )

    Query ->
      ( model
      , Rest.search model.query
      )

    RegisterAnswers maybeAnswers ->
      ( { model | answers = (Maybe.withDefault [] maybeAnswers) }
      , Effects.none
      )
