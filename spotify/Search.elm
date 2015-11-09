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
    { topic : String
    , results :
    }





init : String -> (Model, Effects Action)
init topic =
  ( Model topic "assets/waiting.gif"
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
  div [ style [ "width" => "200px" ] ]
    [ h2 [headerStyle] [text model.topic]
    , div [imgStyle model.gifUrl] []
    , button [ onClick address RequestMore ] [ text "More Please!" ]
    ]


headerStyle : Attribute
headerStyle =
  style
    [ "width" => "200px"
    , "text-align" => "center"
    ]


imgStyle : String -> Attribute
imgStyle url =
  style
    [ "display" => "inline-block"
    , "width" => "200px"
    , "height" => "200px"
    , "background-position" => "center center"
    , "background-size" => "cover"
    , "background-image" => ("url('" ++ url ++ "')")
    ]



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
