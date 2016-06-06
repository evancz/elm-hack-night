module View exposing (root)

import Events exposing (onEnter)
import Html exposing (..)
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


albumsList : List Album -> Html msg
albumsList albums =
    let
        toTile album =
            div [ class "col-xs-2 col-md-3" ]
                [ albumView album ]
    in
        row (List.map toTile albums)


albumView : Album -> Html msg
albumView album =
    panel [ text album.name ]
        [ div []
            [ case List.head album.images of
                Nothing ->
                    span [] [ text "" ]

                Just image ->
                    img [ class "img-responsive", src image ]
                        []
            ]
        ]
