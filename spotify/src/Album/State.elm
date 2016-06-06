module Album.State exposing (..)

import Album.Types exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleDetails ->
            ( { model | showDetails = not model.showDetails }
            , Cmd.none
            )
