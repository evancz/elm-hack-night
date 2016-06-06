module Types exposing (..)

import Album.Types as Album
import Array exposing (Array)
import Http exposing (Error)


type alias Model =
    { query : String
    , results : Maybe (Result Error (Array Album.Model))
    }


type Msg
    = QueryChange String
    | Query
    | SpotifyResponse (Result Error (Array Album.Model))
    | AlbumMsg Int Album.Msg
