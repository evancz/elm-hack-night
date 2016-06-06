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

                Just (Ok results) ->
                    resultsList results
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


resultsList : List Answer -> Html msg
resultsList answers =
    let
        toEntry answer =
            div [ class "col-xs-2 col-md-3" ]
                [ resultView answer ]
    in
        row (List.map toEntry answers)


resultView : Answer -> Html msg
resultView answer =
    div [ class "panel panel-info" ]
        [ div [ class "panel-heading" ]
            [ text "Album" ]
        , div
            [ class "panel-body"
            , style [ ( "height", "10rem" ) ]
            ]
            [ text answer.name ]
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
