module Types exposing (..)

import Http exposing (Error)


type alias Album =
    { name : String
    , images : List Image
    }


type alias Image =
    String


type alias Model =
    { query : String
    , results : Maybe (Result Error (List Album))
    }


type Msg
    = QueryChange String
    | Query
    | SpotifyResponse (Result Error (List Album))
