module View exposing (root)

import Events exposing (onEnter)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


root : Model -> Html Msg
root model =
    div [ style [ ( "margin", "20px 0" ) ] ]
        [ bootstrap
        , containerFluid
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
        [ div [ style [ ( "height", "300px" ) ] ]
            [ case List.head album.images of
                Nothing ->
                    span [] [ text "" ]

                Just image ->
                    img [ class "img-responsive", src image ]
                        []
            ]
        ]



-- Bootstrap.


containerFluid : List (Html a) -> Html a
containerFluid =
    div [ class "container-fluid" ]


row : List (Html a) -> Html a
row =
    div [ class "row" ]


bootstrap : Html a
bootstrap =
    node "link"
        [ href "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
        , rel "stylesheet"
        ]
        []


panel : List (Html msg) -> List (Html msg) -> Html msg
panel head body =
    div [ class "panel panel-info" ]
        [ div [ class "panel-heading" ] head
        , div [ class "panel-body" ] body
        ]
