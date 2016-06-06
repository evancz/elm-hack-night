module Album.State exposing (..)

import Album.Types exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            ( { model | clickCount = model.clickCount + 1 }
            , Cmd.none
            )
