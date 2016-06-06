module State exposing (..)

import Rest
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { query = ""
      , results = Nothing
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        QueryChange newQuery ->
            ( { model | query = newQuery }
            , Cmd.none
            )

        Query ->
            ( model
            , Rest.search model.query
            )

        SpotifyResponse response ->
            ( { model | results = Just response }
            , Cmd.none
            )
