module View.Bootstrap exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


container : List (Html a) -> Html a
container =
    div [ class "container" ]


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
