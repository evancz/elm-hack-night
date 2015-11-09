module Search where

import Effects exposing (Effects, Never)
import Html exposing (..)
import Events exposing (onChange, onEnter)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json exposing ((:=))
import Task
import Signal exposing (message,forwardTo,Address)



-- MODEL


type alias Model =
    { query : String
    , answers : List Answer
    }


type alias Answer =
    { name : String
    }


init : (Model, Effects Action)
init =
  ( Model "" []
  , Effects.none
  )



-- UPDATE


type Action
    = QueryChange String
    | Query
    | RegisterAnswers (Maybe (List Answer))


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    QueryChange newQuery ->
      ( Model newQuery model.answers
      , Effects.none
      )

    Query ->
      ( model
      , search model.query
      )

    RegisterAnswers maybeAnswers ->
      ( Model model.query (Maybe.withDefault [] maybeAnswers)
      , Effects.none
      )



-- VIEW


containerFluid =
  div [class "container-fluid"]


row =
  div [class "row"]


bootstrap =
  node "link"
    [ href "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
    , rel "stylesheet"
    ]
    []


view : Signal.Address Action -> Model -> Html
view address model =
  div
    [style [("margin", "20px 0")]]
    [ bootstrap
    , containerFluid
        [ inputForm address model
        , resultsList address model
        ]
    ]


inputForm address model =
  Html.form
    []
    [ input
        [ type' "text"
        , placeholder "Search for an album..."
        , value model.query
        , onChange address QueryChange
        , onEnter address Query
        ]
        []
    ]


resultsList address model =
  let
    toEntry answer =
      div
        [class "col-xs-2 col-md-3"]
        [resultView answer]
  in
    row (List.map toEntry model.answers)


resultView : Answer -> Html
resultView answer =
  li
    [class "list-group-item"]
    [text answer.name]



-- EFFECTS


(=>) = (,)


search : String -> Effects Action
search query =
  Http.get decodeAnswers (searchUrl query)
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
      Json.map Answer ("name" := Json.string)
  in
    (Json.at ["albums", "items"] (Json.list albumName))
