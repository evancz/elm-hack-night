module Album.View exposing (..)

import Album.Types exposing (..)
import Dialog
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import View.Bootstrap exposing (..)


root : Model -> Html Msg
root model =
    div [ onClick ToggleDetails ]
        [ panel [ text model.name ]
            [ case List.head model.images of
                Nothing ->
                    span [] [ text "" ]

                Just image ->
                    img [ class "img-responsive", src image ]
                        []
            ]
        ]


showDialog : Model -> Maybe (Dialog.Config Msg)
showDialog model =
    if model.showDetails then
        Just
            { closeMessage = Just ToggleDetails
            , header = Just (h2 [] [ text model.name ])
            , body = Just (div [] [ code [] [ text (toString model) ] ])
            , footer = Nothing
            }
    else
        Nothing
