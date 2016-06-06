module State exposing (..)

import Album.State as Album
import Array
import Rest
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { query = ""
      , results = Nothing
      }
    , Rest.search "frank zappa"
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

        AlbumMsg index submsg ->
            case model.results of
                Just (Ok albums) ->
                    case Array.get index albums of
                        Nothing ->
                            ( model, Cmd.none )

                        Just album ->
                            let
                                ( submodel, subcmd ) =
                                    Album.update submsg album
                            in
                                ( { model | results = Just (Ok (Array.set index submodel albums)) }
                                , Cmd.map (AlbumMsg index) subcmd
                                )

                _ ->
                    ( model, Cmd.none )
