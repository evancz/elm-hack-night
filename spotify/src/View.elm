module View exposing (root)

import Album.Types as Album
import Album.View as Album
import Array exposing (Array)
import Events exposing (onEnter)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import View.Bootstrap exposing (..)


root : Model -> Html Msg
root model =
    div []
        [ bootstrap
        , container
            [ inputForm model
            , case model.results of
                Nothing ->
                    p [] [ text "Type a query." ]

                Just (Err err) ->
                    div [ class "alert alert-danger" ] [ text (toString err) ]

                Just (Ok albums) ->
                    albumsList albums
            ]
        ]


inputForm : Model -> Html Msg
inputForm model =
    input
        [ type' "text"
        , placeholder "Search for an album..."
        , value model.query
        , onInput QueryChange
        , onEnter Query
        ]
        []


albumsList : Array Album.Model -> Html Msg
albumsList albums =
    let
        toTile index album =
            div [ class "col-xs-2 col-md-3" ]
                [ Album.root album
                    |> Html.map (AlbumMsg index)
                ]
    in
        row
            (Array.toList albums
                |> List.indexedMap toTile
            )
